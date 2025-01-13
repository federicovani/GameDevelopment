class_name UIControl extends Control

@export var coin_label : Label

func _ready() -> void:
	SignalBus.connect("update_coin_label", _on_update_coin_label)
	coin_label.text = str(0)

func _on_update_coin_label(value : int):
	coin_label.text = str(value)
