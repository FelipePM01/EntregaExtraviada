extends CanvasLayer
@onready var vignetteMaterial = $ColorRect.material
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func expand_vignette(duration : float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(vignetteMaterial,"shader_parameter/softness", 0.5,duration)
	
func shrink_vignette(duration : float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(vignetteMaterial,"shader_parameter/softness", 0,duration)
	
func clear_vignette() -> void:
	vignetteMaterial.set_shader_parameter("softness",0)
	
