extends Node

@warning_ignore("unused_signal")
signal on_health_changed(node : Node, amount_changed : int)

@warning_ignore("unused_signal")
signal portal_crossed()

signal camera_shook(trauma : float)

signal on_health_decreased()
signal update_hearth_label(value : int)

signal on_coin_collected(value : int)
signal update_coin_label(value : int)

signal show_game_over_screen()

func emit_camera_shook(trauma : float = 1):
	camera_shook.emit(trauma)


func emit_on_health_decreased():
	on_health_decreased.emit()
	
func emit_update_hearth_label(value : int):
	update_hearth_label.emit(value)

	
func emit_on_coin_collected(value : int):
	on_coin_collected.emit(value)

func emit_update_coin_label(value : int):
	update_coin_label.emit(value)


func emit_show_game_over_screen():
	show_game_over_screen.emit()
