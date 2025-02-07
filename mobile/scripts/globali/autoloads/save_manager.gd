extends Node

const SAVE_FOLDER_PATH : String = "user://saves/"
const SETTINGS_SAVE_NAME : String = "SettingsData.save"
const LEVEL_STATS_SAVE_NAME : String = "LevelStatsSave.tres"

var settings_data_dict : Dictionary = {}
var level_stats_data = LevelStatsData.new()

func _ready() -> void:
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	SignalBus.connect("save_level_stats", _on_save_level_stats)
	verify_save_directory(SAVE_FOLDER_PATH)
	load_settings_data()
	load_level_stats_data()

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

func on_settings_save(data : Dictionary):
	var save_settings_data_file = FileAccess.open(SAVE_FOLDER_PATH + SETTINGS_SAVE_NAME, FileAccess.WRITE)
	var json_data_string = JSON.stringify(data)
	
	save_settings_data_file.store_line(json_data_string)

func load_settings_data():
	if not FileAccess.file_exists(SAVE_FOLDER_PATH + SETTINGS_SAVE_NAME):
		return
	
	var save_settings_data_file = FileAccess.open(SAVE_FOLDER_PATH + SETTINGS_SAVE_NAME, FileAccess.READ)
	var loaded_data : Dictionary = {}
	
	while save_settings_data_file.get_position() < save_settings_data_file.get_length():
		var json_string = save_settings_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		
		loaded_data = json.get_data()
		
	SettingsSignalBus.emit_load_settings_data(loaded_data)
	loaded_data = {}

func _on_save_level_stats():
	level_stats_data.save_level_stats(LevelStats.level_to_stats)
	level_stats_data.save_level_to_unlocked(SceneManager.level_to_unlocked)
	ResourceSaver.save(level_stats_data, SAVE_FOLDER_PATH + LEVEL_STATS_SAVE_NAME)
	print_debug("level stats saved")

func load_level_stats_data():
	if !FileAccess.file_exists(SAVE_FOLDER_PATH + LEVEL_STATS_SAVE_NAME):
		return
	level_stats_data = ResourceLoader.load(SAVE_FOLDER_PATH + LEVEL_STATS_SAVE_NAME).duplicate(true)
	if(level_stats_data.get_level_to_unlocked() != null):
		SceneManager.level_to_unlocked = level_stats_data.get_level_to_unlocked()
	if(level_stats_data.get_level_stats_dictionary() != null):
		LevelStats.level_to_stats = level_stats_data.get_level_stats_dictionary()
	print_debug("level stats loaded")
