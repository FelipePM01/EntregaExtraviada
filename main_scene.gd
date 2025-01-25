extends Node2D
@export var player: RigidBody2D
@export var terrain: Node2D
@export var menu: CanvasLayer
@export var lose_scene: CanvasLayer
@export var score_ui: CanvasLayer

func _ready() -> void:
	Globals.lose.connect(lose)

func _process(delta):
	if terrain.spawn_polygon_x-Globals.screensize.x < player.position.x :
		terrain.add_hills()
