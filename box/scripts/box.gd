extends RigidBody2D

const TORQUE=30000
const GRAVITY=100
@onready var velocity=Vector2(100,0)
@onready var camera=$Camera2D
@onready var music = $Music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.before_reload.connect(save_progress)
	music.play(Globals.music_progress)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('scroll_up'):
		camera.zoom -= Vector2(0.2, 0.2)
	if event.is_action_pressed('scroll_down'):
		camera.zoom += Vector2(0.2, 0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Globals.is_lose:
		if Input.is_action_pressed("left"):
			apply_torque_impulse(-TORQUE*delta)
		elif Input.is_action_pressed("right"):
			apply_torque_impulse(TORQUE*delta)
		if (linear_velocity.length() >= SingleBubble.forceToPop/2):
			$VignetteEffect.expand_vignette(0.5)
		else:
			$VignetteEffect.shrink_vignette(0.2)
		Globals.score = int(position.x / 100)
	else:
		$VignetteEffect.clear_vignette()

func save_progress():
	var save_file = FileAccess.open("user://highscore", FileAccess.READ)
	if save_file==null:
		save_file=FileAccess.open("user://highscore", FileAccess.WRITE)
		save_file.store_64(int(Globals.score))
		save_file.close()
	var highscore=save_file.get_64()
	save_file.close()
	if highscore<Globals.score:
		highscore=Globals.score
		save_file = FileAccess.open("user://highscore", FileAccess.WRITE)
		save_file.seek(0)
		save_file.store_64(highscore)
	save_file.close()
	Globals.music_progress = music.get_playback_position()
	pass
