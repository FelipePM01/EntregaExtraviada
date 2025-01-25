extends Node2D
@export var player: RigidBody2D
@export var terrain: Node2D
@export var menu: CanvasLayer
@export var lose_scene: CanvasLayer
@export var score_ui: CanvasLayer

func _ready() -> void:
	Globals.lose.connect(lose)

func _process(delta):
	if terrain.start_x - Globals.screensize.x < player.position.x :
		terrain.add_hills()
		
	if (Input.is_action_pressed("Spacebar") and menu.visible and not Globals.is_lose):
		$Truck/BangSound.play()
		player.gravity_scale = 1
		player.apply_impulse(Vector2(600, -30))
		player.apply_torque_impulse(8000)
		menu.visible = false

func lose():
	lose_scene.visible = true
	score_ui.visible = false
	pass
