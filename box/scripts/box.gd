extends RigidBody2D

const TORQUE=300
const GRAVITY=100
@onready var velocity=Vector2(100,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		apply_torque(TORQUE*delta)
	elif Input.is_action_pressed("ui_right"):
		apply_torque(-TORQUE*delta)
