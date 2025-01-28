extends Node

var main_menu : String = "main_menu"
var tutorial : String = "tutorial"
var level_selector : String = "level_selector"
var livello_federico : String = "livello_federico"
var livello_sara : String = "livello_sara"
var livello_elisa : String = "livello_elisa"

var scene_to_file : Dictionary = {
	main_menu : "res://scenes/globali/UI/menu/main_menu.tscn",
	level_selector : "res://scenes/globali/UI/menu/level_selector.tsc",
	tutorial : "",
	livello_federico : "res://scenes/livello_federico/livello_federico.tscn",
	livello_elisa : "res://scenes/livello_elisa/livello_elisa.tscn",
	livello_sara : "res://scenes/livello_sara/livello_sara.tscn"
}

var level_to_locked : Dictionary = {
	tutorial : 1,
	livello_federico : 0,
	livello_elisa : 0,
	livello_sara : 0
}

var level_order : Array[String] = [tutorial, livello_federico, livello_elisa, livello_sara]

var current_level : String

func _ready() -> void:
	pass
	
func get_scene_file(level : String) -> String:
	if scene_to_file.has(level):
		return scene_to_file .get(level)
	else:
		print_debug("Can't find any level: "+ level)
		return "error_string"

func is_level_unlocked(level : String) -> bool:
	if level_to_locked.has(level):
		return level_to_locked.get(0)
	else:
		print_debug("Can't find any level: "+ level)
		return 0

func get_next_level(level : String) -> String:
	var i : int = 0
	for lvl in level_order:
		i += 1
		if(lvl == level):
			return level_order[i+1]
	print_debug("Can't find any next level for: "+ level)
	return "error_string"

func reload_current_level():
	get_tree().reload_current_scene()

func go_to_main_menu():
	go_to_scene(main_menu)

func go_to_next_level():
	var next_level : String = get_next_level(current_level)
	go_to_scene(next_level)

func go_to_scene(scene : String):
	current_level = scene
	var scene_file : String = get_scene_file(scene)
	get_tree().change_scene_to_file(scene_file)
	SignalBus.emit_level_changed()
