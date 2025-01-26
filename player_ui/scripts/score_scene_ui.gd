extends CanvasLayer
@export var score_text: Label
@export var timer_text: Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Score: {}m".format([int(Globals.score)], "{}")
	var minutes = int(Globals.elapsedTime) / 60
	var seconds = int(Globals.elapsedTime) % 60
	timer_text.text = "Time: %02d:%02d" % [minutes, seconds]
