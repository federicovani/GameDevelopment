extends State

func on_enter():
	playback.travel(character.death_animation)
	SignalBus.emit_camera_shook(2)
	SignalBus.emit_show_game_over_screen()
