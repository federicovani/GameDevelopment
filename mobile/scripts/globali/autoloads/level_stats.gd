extends Node

var time : int = 0
var deaths : int = 0
var coins : int = 0
var diamonds : int = 0
var checkpoint_taken : bool = false

func _ready() -> void:
	SignalBus.connect("level_changed", _on_level_changed)
	SignalBus.connect("on_coin_collected", _on_coin_collected)
	SignalBus.connect("diamond_collected", _on_diamond_collected)
	SignalBus.connect("checkpoint_taken", _on_checkpoint_taken)
	SignalBus.connect("new_death", _on_new_death)
	SignalBus.connect("portal_crossed", _on_portal_crossed)

func _process(delta: float) -> void:
	time += delta

func _on_level_changed():
	time = 0
	deaths = 0
	coins = 0
	diamonds = 0
	checkpoint_taken = false

func _on_coin_collected(value : int):
	coins += value

func _on_diamond_collected():
	diamonds += 1

func _on_checkpoint_taken():
	checkpoint_taken = true

func is_checkpoint_taken() -> bool:
	return checkpoint_taken

func _on_new_death():
	deaths += 1

func _on_portal_crossed():
	SignalBus.emit_update_level_stats_ui(time, deaths, coins, diamonds)
