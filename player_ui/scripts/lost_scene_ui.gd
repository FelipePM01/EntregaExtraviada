extends CanvasLayer

@export var score_text: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Highscore:\n{}m".format([int(Globals.score)], "{}")
	if (Input.is_action_pressed("Spacebar") and visible):
		_on_restart_button_pressed()


func _on_restart_button_pressed() -> void:
	Globals.before_reload.emit()
	get_tree().reload_current_scene()
	Globals.is_lose = false
	visible = false
