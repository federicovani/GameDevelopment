extends Node

var window_mode_index : int = 0
var resolution_index : int = 0
var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0

func _ready() -> void:
	handle_signals()
	create_storage_dictionary()

func create_storage_dictionary() -> Dictionary:
	var settings_container_dict : Dictionary = {
		"window_mode_index" : window_mode_index,
		"resolution_index" : resolution_index,
		"master_volume" : master_volume,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume,
		"move_left" : InputMap.action_get_events("move_left"),
		"move_right" : InputMap.action_get_events("move_right"),
		"jump" : InputMap.action_get_events("jump"),
		"attack" : InputMap.action_get_events("attack")
	}
	
	return settings_container_dict

func on_window_mode_selected(index : int):
	window_mode_index = index


func on_resolution_selected(index : int):
	resolution_index = index


func on_master_sound_set(value : float):
	master_volume = value


func on_music_sound_set(value : float):
	music_volume = value


func on_sfx_sound_set(value : float):
	sfx_volume = value


func handle_signals():
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
