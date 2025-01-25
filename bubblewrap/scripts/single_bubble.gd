extends Node2D
@export var playerRigidbody : RigidBody2D
const forceToPop: float = 1000

var hasPopped = false
var IsColliding = false
var timesCollided = 0
var lastVelocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#lastVelocity = playerRigidbody.linear_velocity.length()
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	IsColliding = true
	print_debug(playerRigidbody.linear_velocity.length())
	if (playerRigidbody.linear_velocity.length() > forceToPop):
		return
	pop_bubble()
	timesCollided += 1
	if (timesCollided > 1 and timesCollided < 3):
		#Display Player Lost screen and score
		print_debug("Player Lost")


func _on_area_2d_body_exited(body: Node2D) -> void:
	IsColliding = false

func pop_bubble() -> void:
	hasPopped = true
	var randomTime = randi_range(0,0.005)
	await get_tree().create_timer(randomTime).timeout
	$AudioStreamPlayer2D.play()
	$Sprite2D.visible = false
