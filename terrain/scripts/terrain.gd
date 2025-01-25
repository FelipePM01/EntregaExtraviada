extends Node2D

@export var ground_collision: StaticBody2D
@export var texture: CompressedTexture2D
@export var noise: NoiseTexture2D
@export var vertices = 10

@export var start_height=200

@export var bezier_min_smoothness=30
@export var bezier_max_smoothness=70

@export_range(0, 179) var hill_angle: float = 30
@export_range(20, 200) var hill_spike: float = 100

@export var start_x = 0
@export var start_y = 0

var point_marker = preload("res://utils/markers/point_marker.tscn")
var edge_marker = preload("res://utils/markers/edge_marker.tscn")

@onready var hill_angle_rad = deg_to_rad(hill_angle)

func _ready():
	randomize()
	add_hills()

func add_hills():
	var start_vertex = Vector2(start_x, start_y)
	var end_vertex = Vector2(start_vertex.x + Globals.screensize.x, 
							start_vertex.y + Globals.screensize.x * tan(hill_angle_rad))
	var vertex_array = Array()
	for i in range(1, vertices):
		vertex_array.append(Vector2(lerp(start_vertex.x, end_vertex.x, float(i) / vertices),
									lerp(start_vertex.y,end_vertex.y,float(i)/vertices) + randf_range(-hill_spike, hill_spike)))
		
	var curve=Curve2D.new()
	for i in vertex_array:
		var smoothness = randf_range(bezier_min_smoothness, bezier_max_smoothness)
		print(smoothness)
		curve.add_point(i,Vector2(-smoothness * cos(hill_angle_rad), -smoothness * sin(hill_angle_rad)),
						  Vector2(smoothness * cos(hill_angle_rad), smoothness * sin(hill_angle_rad)))
		var p = point_marker.instantiate()
		p.position = i
		add_child(p)
		p = edge_marker.instantiate()
		p.position = i + Vector2(-smoothness * cos(hill_angle_rad), -smoothness * sin(hill_angle_rad))
		add_child(p)
		p = edge_marker.instantiate()
		p.position = i + Vector2(smoothness * cos(hill_angle_rad), smoothness * sin(hill_angle_rad))
		add_child(p)
		
	curve.add_point(end_vertex)
	var points = curve.get_baked_points()
	$Line2D.points += points
	var poly= PackedVector2Array(points)
	poly.insert(0,start_vertex)
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
	
	start_y = end_vertex.y
	start_x = end_vertex.x
