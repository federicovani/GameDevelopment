class_name PlayerStatsManager extends Node

var current_coin_amount : int = 0
var current_coin_max : int = 99

func _ready() -> void:
	SignalBus.connect("on_coin_collected", _on_coin_collected)

func _on_coin_collected(value : int):
	current_coin_amount += value
	if current_coin_amount > current_coin_max:
		current_coin_amount = 0
		#To-Do Add one life when you collect 100 coins
	
	SignalBus.emit_update_coin_label(current_coin_amount)
