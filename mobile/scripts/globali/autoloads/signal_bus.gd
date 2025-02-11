extends Node

signal on_health_changed(node : Node, amount_changed : int)

signal portal_crossed()

signal fallen_in_lava()

signal forced_death()

#region Level Stats
signal save_level_stats()
signal level_changed()
signal level_reloaded()
signal new_death()
signal diamond_collected()
signal checkpoint_taken()
signal update_level_stats_ui(time : float, deaths : int, coins : int, diamonds : int)
#endregion

signal camera_shook(trauma : float)

#region Update Player Stats
signal on_health_decreased()
signal update_hearth_label(value : int)

signal on_coin_collected(value : int)
signal update_coin_label(value : int)
#endregion

signal show_game_over_screen()


func emit_fallen_in_lava():
	fallen_in_lava.emit()


func emit_forced_death():
	forced_death.emit()


#region Emit Level Stats
func emit_save_level_stats():
	save_level_stats.emit()

func emit_level_changed():
	level_changed.emit()

func emit_level_reloaded():
	level_reloaded.emit()

func emit_new_death():
	new_death.emit()

func emit_diamond_collected():
	diamond_collected.emit()

func emit_checkpoint_taken():
	checkpoint_taken.emit()

func emit_update_level_stats_ui(time : float, deaths : int, coins : int, diamonds : int):
	update_level_stats_ui.emit(time, deaths, coins, diamonds)
#endregion


func emit_camera_shook(trauma : float = 1):
	camera_shook.emit(trauma)


#region Emit Update Player Stats
func emit_on_health_decreased():
	on_health_decreased.emit()
	
func emit_update_hearth_label(value : int):
	update_hearth_label.emit(value)

	
func emit_on_coin_collected(value : int):
	on_coin_collected.emit(value)

func emit_update_coin_label(value : int):
	update_coin_label.emit(value)
#endregion


func emit_show_game_over_screen():
	show_game_over_screen.emit()
