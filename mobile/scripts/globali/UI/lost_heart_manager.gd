extends Control

@export var lost_heart_icon : PackedScene

func _ready() -> void:
	SignalBus.connect("on_health_decreased", on_signal_health_decreased)

func on_signal_health_decreased():
	var sprite_instance : Sprite2D = lost_heart_icon.instantiate()
	Global.playerBody.add_child.call_deferred(sprite_instance)
