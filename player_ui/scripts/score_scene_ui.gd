extends Control
@export var playerTransform: Node2D

var playerStartPosition
var relativePositionScore = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerStartPosition = playerTransform.position
	$ScoreValueText.text = str(relativePositionScore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	relativePositionScore = playerTransform.position.x - playerStartPosition.x
	if (relativePositionScore < 0):
		relativePositionScore = 0
	$ScoreValueText.text = str(int(relativePositionScore))
