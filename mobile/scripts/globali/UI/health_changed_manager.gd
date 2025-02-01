extends Control

@export var health_change_label : PackedScene
@export var damage_color : Color = Color.DARK_RED
@export var heal_color : Color = Color.WEB_GREEN

func _ready() -> void:
	SignalBus.connect("on_health_changed", on_signal_health_changed)

func on_signal_health_changed(node : Node, amount_changed : int):
	if(amount_changed <= 0):
		var label_instance : Label = health_change_label.instantiate()
		node.add_child.call_deferred(label_instance)
		label_instance.text = str(amount_changed)
		label_instance.modulate = damage_color
