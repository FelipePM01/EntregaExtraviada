extends RigidBody2D

const force = 5000
const torque = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_action_pressed("Spacebar")):
		apply_impulse(Vector2.UP*force*delta)
	if (Input.is_action_pressed("left")):
		apply_torque_impulse(-torque)
	if (Input.is_action_pressed("right")):
		apply_torque_impulse(torque)
