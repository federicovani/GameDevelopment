extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.DARK_RED
@export var heal_color : Color = Color.WEB_GREEN

func _ready() -> void:
	SignalBus.connect("on_health_changed", on_signal_health_changed)

func on_signal_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_changed_label.instantiate()
	node.add_child(label_instance)
	print_debug(str(node.get_children()))
	label_instance.text = str(amount_changed)
	print_debug(label_instance.text)
	
	if(amount_changed >= 0):
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
