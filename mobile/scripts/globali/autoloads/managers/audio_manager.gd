extends Node

@export var bg_music_player : AudioStreamPlayer

func _ready() -> void:
	SignalBus.connect("level_changed", _on_level_changed)

func _on_level_changed():
	update_music_for_scene()

func update_music_for_scene():
	var current_level_music = str(SceneManager.current_level + "_music")
	#Same music for main menu and level selector
	if(current_level_music == "level_selector_music"):
		current_level_music = "main_menu_music"
	bg_music_player["parameters/switch_to_clip"] = current_level_music
