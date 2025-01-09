class_name MainMenu extends Control

@onready var start_level : PackedScene = preload("res://scenes/livello_federico/livello_federico.tscn")
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer

func _ready() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)

func _on_start_button_down() -> void:
	get_tree().change_scene_to_packed(start_level)

func _on_options_button_down() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_options_menu():
	margin_container.visible = true
	options_menu.visible = false

func _on_quit_button_down() -> void:
	get_tree().quit()
