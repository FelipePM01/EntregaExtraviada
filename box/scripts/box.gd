extends RigidBody2D

const TORQUE=30000
const GRAVITY=100
@onready var velocity=Vector2(100,0)
@onready var camera=$Camera2D
# Called when the node enters the scene tree for the first time.

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('scroll_up'):
		camera.zoom -= Vector2(0.2, 0.2)
	if event.is_action_pressed('scroll_down'):
		camera.zoom += Vector2(0.2, 0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		apply_torque_impulse(-TORQUE*delta)
	elif Input.is_action_pressed("right"):
		apply_torque_impulse(TORQUE*delta)
	Globals.score = position.x / 100
