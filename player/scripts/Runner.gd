extends CharacterBody2D

@export var speed = 200
@export var gravity = 1500
@export var camera: Camera2D

func _input(event):
	if event.is_action_pressed('scroll_up'):
		camera.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed('scroll_down'):
		camera.zoom += Vector2(0.1, 0.1)
		
func _physics_process(delta):
	velocity.x = 0
	velocity.y += gravity * delta
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	velocity.x *= speed
	move_and_slide()
