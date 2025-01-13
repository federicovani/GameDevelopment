extends Node

@warning_ignore("unused_signal")
signal on_health_changed(node : Node, amount_changed : int)

@warning_ignore("unused_signal")
signal portal_crossed()
	
signal on_coin_collected(value : int)

signal update_coin_label(value : int)


func emit_on_coin_collected(value : int):
	on_coin_collected.emit(value)

func emit_update_coin_label(value : int):
	update_coin_label.emit(value)
