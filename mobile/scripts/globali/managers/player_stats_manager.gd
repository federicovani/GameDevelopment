extends Node

var current_hearth_amount : int = 3
var max_hearth_amount : int = 3
var current_coin_amount : int = 0
var current_coin_max : int = 99

func _ready() -> void:
	SignalBus.connect("on_health_decreased", _on_health_decreased)
	SignalBus.connect("on_coin_collected", _on_coin_collected)

func _process(_delta: float) -> void:
	SignalBus.emit_update_hearth_label(current_hearth_amount)
	SignalBus.emit_update_coin_label(current_coin_amount)

func _on_health_decreased():
	current_hearth_amount -= 1
	if current_hearth_amount == 0:
		pass #Da decidere

func _on_coin_collected(value : int):
	current_coin_amount += value
	if current_coin_amount > current_coin_max:
		current_coin_amount = 0
		#To-Do Add one life when you collect 100 coins
