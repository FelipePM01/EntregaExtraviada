extends CanvasLayer

@export var score_text: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace wi


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if (Input.is_action_pressed("Spacebar") and visible):
		_on_restart_button_pressed()


func _on_restart_button_pressed() -> void:
	Globals.before_reload.emit()
	get_tree().reload_current_scene()
	Globals.is_lose = false
	visible = false


func _on_visibility_changed() -> void:
	if visible:
		var save_file = FileAccess.open("user://highscore", FileAccess.READ)
		var highscore
		if save_file:
			highscore=save_file.get_64()
			save_file.close()
			if int(Globals.score)>highscore:
				highscore=int(Globals.score)
		else:
			highscore=int(Globals.score)
		score_text.text = "Highscore:\n{}m".format([highscore], "{}")
