extends Node2D

@export var slices = 40
@export var hill_width = 512
@export var hill_range = 100
@export var hill_angle = 10
@export var hill_sharpness = 20
@export var ground_collision: StaticBody2D
@export var texture: CompressedTexture2D
@export var noise: NoiseTexture2D
var terrain = Array()

func _ready():
	randomize()
	terrain = Array()
	var start_y = Globals.screensize.y * 3/4
	terrain.append(Vector2(0, start_y))
	add_hills()
	
func get_point(x:float, height):
	return hill_sharpness * noise.noise.get_noise_1d(x) + x * tan(hill_angle) + height * sin(2 * PI * x/ hill_width)

func add_hills():
	var start = terrain[-1]
	var poly = PackedVector2Array()
	var hill_slices = hill_width / slices
	poly.append(Vector2(start.x, start.y+300))
	poly.append(Vector2(start.x, start.y))
	var height = randi() % hill_range
	for j in range(1, slices+1):
		var hill_point = Vector2()
		hill_point.x = start.x + j * hill_slices
		hill_point.y = get_point(hill_point.x, height)
		$Line2D.add_point(hill_point)
		terrain.append(hill_point)
		poly.append(hill_point)

	poly.append(Vector2(terrain[-1].x, terrain[-1].y + 300))
	var shape = CollisionPolygon2D.new()
	shape.polygon = poly
	ground_collision.add_child(shape)

	var ground = Polygon2D.new()
	ground.polygon = poly
	ground.texture = texture
	add_child(ground)
		
		
