extends Node2D
@export var player: RigidBody2D
@export var terrain: Node2D
@export var menu: CanvasLayer
@export var lose_scene: CanvasLayer
@export var score_ui: CanvasLayer

func _ready() -> void:
	Globals.lose.connect(lose)

func _process(delta):
	#if terrain.terrain[-1].x < player.position.x + Globals.screensize.x / 2:
	#	terrain.add_hills()
		
	if (Input.is_action_pressed("Spacebar") and menu.visible):
		player.gravity_scale = 1
		player.apply_impulse(Vector2(600, -30))
		player.apply_torque(80000)
		menu.visible = false

func lose():
	lose_scene.visible = true
	score_ui.visible = false
	pass
