extends RigidBody2D

const TORQUE=300
const GRAVITY=100
@onready var velocity=Vector2(100,0)
@onready var camera=$Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.zoom=Vector2(10,10)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('scroll_up'):
		camera.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed('scroll_down'):
		camera.zoom += Vector2(0.1, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		apply_torque(TORQUE*delta)
	elif Input.is_action_pressed("ui_right"):
		apply_torque(-TORQUE*delta)
