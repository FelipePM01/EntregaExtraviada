extends Node
var bubbles: Array[SingleBubble] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if (child is SingleBubble):
			bubbles.append(child as SingleBubble)
	

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
