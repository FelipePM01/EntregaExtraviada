extends Node

@onready var screensize = get_viewport().get_visible_rect().size
@onready var record:float = 0
@onready var score: float = 0
@onready var is_lose: bool = false

var started_game: bool = false
var elapsedTime: float = 0.0

#Keep music progress for reload
#I'm playing it at the Box script
var music_progress = 0.0	

signal before_reload

signal lose

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (started_game&&!is_lose):
		elapsedTime += delta
