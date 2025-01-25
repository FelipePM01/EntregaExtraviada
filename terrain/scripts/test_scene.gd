extends Node2D
@export var player: RigidBody2D
@export var terrain: Node2D

func _process(delta):
	if terrain.spawn_polygon_x < player.position.x + Globals.screensize.x / 2:
		terrain.add_hills()
