extends Node

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://scripts/resources/settings/default_settings.tres")
@onready var keybind_resource : KeybindResource = preload("res://scripts/resources/settings/keybind_resource.tres")

var window_mode_index : int = 0
var resolution_index : int = 0
var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0

var loaded_data : Dictionary = {}

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
		"keybinds" : create_keybinds_dictionary()
	}
	
	return settings_container_dict

func create_keybinds_dictionary() -> Dictionary:
	var keybinds_container_dict = {
		keybind_resource.MOVE_LEFT : keybind_resource.move_left_key,
		keybind_resource.MOVE_RIGHT : keybind_resource.move_right_key,
		keybind_resource.JUMP : keybind_resource.jump_key,
		keybind_resource.CROUCH : keybind_resource.crouch_key,
		keybind_resource.DASH : keybind_resource.dash_key,
		keybind_resource.ATTACK : keybind_resource.attack_key
	}
	
	return keybinds_container_dict

func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_WINDOW_MODE_INDEX
	return window_mode_index

func get_resolution_index() -> int:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_RESOLUTION_INDEX
	return resolution_index

func get_master_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MASTER_VOLUME
	return master_volume

func get_music_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_MUSIC_VOLUME
	return music_volume

func get_sfx_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SETTINGS.DEFAULT_SFX_VOLUME
	return sfx_volume

func get_keybind(action : String):
	if !loaded_data.has("keybinds"):
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.DEFAULT_MOVE_LEFT_KEY
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.DEFAULT_MOVE_RIGHT_KEY
			keybind_resource.JUMP:
				return keybind_resource.DEFAULT_JUMP_KEY
			keybind_resource.CROUCH:
				return keybind_resource.DEFAULT_CROUCH_KEY
			keybind_resource.DASH:
				return keybind_resource.DEFAULT_DASH_KEY
			keybind_resource.ATTACK:
				return keybind_resource.DEFAULT_ATTACK_KEY
	else:
		match action:
			keybind_resource.MOVE_LEFT:
				return keybind_resource.move_left_key
			keybind_resource.MOVE_RIGHT:
				return keybind_resource.move_right_key
			keybind_resource.JUMP:
				return keybind_resource.jump_key
			keybind_resource.CROUCH:
				return keybind_resource.crouch_key
			keybind_resource.DASH:
				return keybind_resource.dash_key
			keybind_resource.ATTACK:
				return keybind_resource.attack_key

func set_window_mode_index(index : int):
	window_mode_index = index

func set_resolution_index(index : int):
	resolution_index = index

func set_master_volume(value : float):
	master_volume = value

func set_music_volume(value : float):
	music_volume = value

func set_sfx_volume(value : float):
	sfx_volume = value

func set_keybind(action : String, event):
	match action:
		keybind_resource.MOVE_LEFT:
			keybind_resource.move_left_key = event
		keybind_resource.MOVE_RIGHT:
			keybind_resource.move_right_key = event
		keybind_resource.JUMP:
			keybind_resource.jump_key = event
		keybind_resource.CROUCH:
			keybind_resource.crouch_key = event
		keybind_resource.DASH:
			keybind_resource.dash_key = event
		keybind_resource.ATTACK:
			keybind_resource.attack_key = event

func on_keybinds_loaded(data : Dictionary):
	var loaded_move_left = InputEventKey.new()
	var loaded_move_right = InputEventKey.new()
	var loaded_jump = InputEventKey.new()
	var loaded_crouch = InputEventKey.new()
	var loaded_dash = InputEventKey.new()
	var loaded_attack = InputEventKey.new()
	
	loaded_move_left.set_physical_keycode(int(data.move_left))
	loaded_move_right.set_physical_keycode(int(data.move_right))
	loaded_jump.set_physical_keycode(int(data.jump))
	loaded_crouch.set_physical_keycode(int(data.crouch))
	loaded_dash.set_physical_keycode(int(data.dash))
	loaded_attack.set_physical_keycode(int(data.attack))
	
	keybind_resource.move_left_key = loaded_move_left
	keybind_resource.move_right_key = loaded_move_right
	keybind_resource.jump_key = loaded_jump
	keybind_resource.crouch_key = loaded_crouch
	keybind_resource.dash_key = loaded_dash
	keybind_resource.attack_key = loaded_attack

func on_settings_data_loaded(data : Dictionary):
	loaded_data = data
	
	set_window_mode_index(loaded_data.window_mode_index)
	set_resolution_index(loaded_data.resolution_index)
	set_master_volume(loaded_data.master_volume)
	set_music_volume(loaded_data.music_volume)
	set_sfx_volume(loaded_data.sfx_volume)
	on_keybinds_loaded(loaded_data.keybinds)

func handle_signals():
	SettingsSignalBus.on_window_mode_selected.connect(set_window_mode_index)
	SettingsSignalBus.on_resolution_selected.connect(set_resolution_index)
	SettingsSignalBus.on_master_sound_set.connect(set_master_volume)
	SettingsSignalBus.on_music_sound_set.connect(set_music_volume)
	SettingsSignalBus.on_sfx_sound_set.connect(set_sfx_volume)
	
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
