extends Node

@export var bg_music_player : AudioStreamPlayer
var current_level : String

func _ready() -> void:
	current_level = Global.current_level

func _process(_delta: float) -> void:
	if(current_level != Global.current_level):
		current_level = Global.current_level
		update_music_for_scene()

func update_music_for_scene():
	var current_level_music = str(current_level + "_music")
	bg_music_player["parameters/switch_to_clip"] = current_level_music
