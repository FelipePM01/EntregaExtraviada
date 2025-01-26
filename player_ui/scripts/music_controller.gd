extends CanvasLayer

@onready var master_bus=AudioServer.get_bus_index("Master")

func _ready() -> void:
	$HSlider.value=AudioServer.get_bus_volume_db(master_bus)
	

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus,value)
	
	if value==-30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
