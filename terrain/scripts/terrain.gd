extends Node

@export var slices = 20
@export var hill_width = 512
@export var hill_range = 100
@export var player: CharacterBody2D
@export var ground_collision: StaticBody2D
@export var texture: CompressedTexture2D

var screensize
var terrain = Array()

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	terrain = Array()
	var start_y = screensize.y * 3/4 #+ (-hill_range + randi() % hill_range*2)
	terrain.append(Vector2(0, start_y))
	add_hills()
	while terrain[-1].x < player.position.x + screensize.x / 2:
		add_hills()


func _process(delta):
	if terrain[-1].x < player.position.x + screensize.x / 2:
		add_hills()
	

func add_hills():
	var start = terrain[-1]
	var poly = PackedVector2Array()
	var height = randf() * hill_range
	var hill_slices = hill_width / slices
	poly.append(Vector2(start.x, start.y+300))
	poly.append(Vector2(start.x, start.y))
	for j in range(1, slices+1):
		var hill_point = Vector2()
		hill_point.x = start.x + j * hill_slices
		hill_point.y = start.y - height * sin(2 * PI * j / slices) + hill_point.x * 0.1
		terrain.append(hill_point)
		poly.append(hill_point)
	poly.append(Vector2(terrain[-1].x, start.y + 300 + terrain[-1].x * 0.1))
	var shape = CollisionPolygon2D.new()
	var ground = Polygon2D.new()
	ground_collision.add_child(shape)
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = texture
	add_child(ground)
		
		
