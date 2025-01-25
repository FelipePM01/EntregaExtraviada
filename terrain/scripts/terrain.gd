extends Node2D

@export var slices = 40
@export var hill_width = 512
@export var hill_range = 100
@export var hill_angle = 10
@export var hill_sharpness = 20
@export var ground_collision: StaticBody2D
@export var texture: CompressedTexture2D
@export var noise: NoiseTexture2D
@export var vertices = 10
var terrain = Array()

@export var start_offset=200
@onready var start_height=start_offset
@onready var start_x=0
@onready var spawn_polygon_x=Globals.screensize.x/2
@export var bezier_x_in_out=5
@export var bezier_max_y_in_out=5

func _ready():
	randomize()
	terrain = Array()
	var start_y = 0
	terrain.append(Vector2(1, start_y))
	add_hills()
	add_hills()

func add_hills():
	
	
	var start_vertex=Vector2(start_x,start_height)
	var end_vertex=start_vertex+Globals.screensize
	var vertex_array=Array()
	for i in range(vertices):
		randomize()
		vertex_array.append(Vector2(lerp(start_vertex.x,end_vertex.x,float(i)/vertices),lerp(start_vertex.y,end_vertex.y,float(i)/vertices)+randf_range(-100,100)))
		
	var curve=Curve2D.new()
	for i in vertex_array:
		var bezier_y=randf_range(-bezier_max_y_in_out,bezier_max_y_in_out)
		curve.add_point(i,Vector2(-bezier_x_in_out,bezier_y),Vector2(bezier_x_in_out,-bezier_y))
	curve.add_point(end_vertex)
	var points=curve.get_baked_points()
	$Line2D.points=points
	var poly= PackedVector2Array(points)
	poly.insert(0,start_vertex+Vector2(0,2000))
	poly.insert(0,end_vertex+Vector2(0,2000))
	var shape=CollisionPolygon2D.new()
	shape.polygon=poly
	ground_collision.add_child(shape)
	

	var ground = Polygon2D.new()
	ground.polygon = poly
	ground.texture = texture
	ground.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	add_child(ground)
	
	start_height=end_vertex.y
	start_x=end_vertex.x
	spawn_polygon_x+=Globals.screensize.x
