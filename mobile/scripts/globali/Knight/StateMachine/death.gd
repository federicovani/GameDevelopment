extends State

func _ready() -> void:
	SignalBus.connect("forced_death", _on_forced_death)

func on_enter():
	playback.travel(character.death_animation)
	death_signals()

func death_signals():
	SignalBus.emit_new_death()
	SignalBus.emit_camera_shook(2)
	SignalBus.emit_show_game_over_screen()

func _on_forced_death():
	emit_signal("interrupt_state", self)
