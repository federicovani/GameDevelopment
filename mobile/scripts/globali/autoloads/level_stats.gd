extends Node

var time = 0
var deaths = 0
var coins = 0
var diamonds = 0

func _ready() -> void:
	SignalBus.connect("level_changed", _on_level_changed)
	SignalBus.connect("on_coin_collected", _on_coin_collected)
	SignalBus.connect("diamond_collected", _on_diamond_collected)
	SignalBus.connect("new_death", _on_new_death)
	SignalBus.connect("portal_crossed", _on_portal_crossed)

func _process(delta: float) -> void:
	time += delta

func _on_level_changed():
	time = 0
	deaths = 0
	coins = 0
	diamonds = 0

func _on_coin_collected(value : int):
	coins += value

func _on_diamond_collected():
	diamonds += 1

func _on_new_death():
	deaths += 1

func _on_portal_crossed():
	SignalBus.emit_update_level_stats_ui(time, deaths, coins, diamonds)
