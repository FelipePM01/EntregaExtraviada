extends Node2D
@export var player: RigidBody2D
@export var terrain: Node2D

func _process(delta):
	if terrain.spawn_polygon_x-Globals.screensize.x < player.position.x :
		terrain.add_hills()
