extends Node2D
class_name SingleBubble

@onready var cooldownTimer: Timer = $CooldownTimer
var isCooldown = false

@export var playerRigidbody : RigidBody2D
const forceToPop: float = 700

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

func _physics_process(delta: float) -> void:
	lastVelocity = playerRigidbody.linear_velocity

func _on_area_2d_body_entered(body: Node2D) -> void:
	IsColliding = true
	if (isCooldown):
		return
	if (lastVelocity.length() < forceToPop):
		return
	if (!hasPopped):
		pop_bubble()
	timesCollided += 1
	if (timesCollided > 1 and timesCollided < 3):
		#Display Player Lost screen and score
		#get_tree().reload_current_scene()
		Globals.lose.emit()
		Globals.is_lose = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	IsColliding = false

func pop_bubble():
	
	hasPopped = true
	var randomTime = randi_range(0,0.005)
	await get_tree().create_timer(randomTime).timeout
	$AudioStreamPlayer2D.play()
	$Line2D.visible = true
	$Sprite2D.visible = false
	start_cooldown()

func start_cooldown():
	isCooldown = true
	cooldownTimer.start()

func _on_cooldown_timer_timeout():
	isCooldown = false
