extends RigidBody2D

const TORQUE=30000
const GRAVITY=100

@export var dirt_effect_cooldown: float

@onready var dirt_effect = preload("res://box/effects/scenes/DirtParticle.tscn")
@onready var dirtCooldownTimer: Timer = $DirtEffectTimer
var dirtCooldown = false

@onready var velocity=Vector2(100,0)
@onready var camera=$Camera2D
@onready var music = $Music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.before_reload.connect(save_music_progress)
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
		Globals.score = position.x / 100
	else:
		$VignetteEffect.clear_vignette()

func save_music_progress():
	Globals.music_progress = music.get_playback_position()
	pass
		
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if (linear_velocity.length() >= SingleBubble.forceToPop/2 and state.get_contact_count() > 0):
		var dirt_effect_instance = dirt_effect.instantiate()
		add_child(dirt_effect_instance)
		dirtCooldownTimer.start()
		dirtCooldown = true
		print_debug("Instantiating Dirt")


func _on_dirt_effect_timer_timeout() -> void:
	dirtCooldown = false
