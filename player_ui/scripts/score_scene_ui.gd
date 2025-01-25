extends CanvasLayer
@export var score_text: Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_text.text = "Score: {}m".format([Globals.score], "{}")
	$Fps.text = str(Engine.get_frames_per_second())
