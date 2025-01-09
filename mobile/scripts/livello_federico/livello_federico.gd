extends Node2D

@export var next_level : String = "res://scenes/livello_sara/livello_sara.tscn"

func _ready() -> void:
	SignalBus.connect("portal_crossed", on_portal_crossed)

func on_portal_crossed():
	get_tree().change_scene_to_file(next_level)
