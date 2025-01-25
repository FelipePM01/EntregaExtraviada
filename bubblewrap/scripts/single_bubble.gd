extends Node2D

var hasPopped = false
var IsColliding = false
var timesCollided = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	IsColliding = true
	pop_bubble()
	if (timesCollided > 1 and timesCollided < 3):
		print_debug("Player Lost")
	timesCollided += 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	IsColliding = false

func pop_bubble() -> void:
	hasPopped = true
	var randomTime = randi_range(0,0.005)
	await get_tree().create_timer(randomTime).timeout
	$AudioStreamPlayer2D.play()
	$Sprite2D.visible = false
