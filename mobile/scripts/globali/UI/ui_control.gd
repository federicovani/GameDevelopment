class_name UIControl extends Control

@export var hearths : Array[Node]
@export var coin_label : Label

func _ready() -> void:
	SignalBus.connect("update_coin_label", _on_update_coin_label)
	SignalBus.connect("update_hearth_label", _on_update_hearth_label)
	coin_label.text = str(0)

func _on_update_coin_label(value : int):
	coin_label.text = str(value)

func _on_update_hearth_label(current_hearth_amount : int):
	for i in 3:
		if(i < current_hearth_amount):
			hearths[i].show()
		else:
			hearths[i].hide()
