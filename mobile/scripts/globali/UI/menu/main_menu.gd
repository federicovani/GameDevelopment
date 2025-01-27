class_name MainMenu extends Control

@onready var start_level : PackedScene = preload("res://scenes/livello_federico/livello_federico.tscn")
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer

@onready var start: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Start
@onready var options: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Options
@onready var quit: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Quit

func _ready() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)

func _process(_delta: float) -> void:
	update_button_scale()

func update_button_scale():
	button_hover(start, 1.15, 0.2)
	button_hover(options, 1.15, 0.2)
	button_hover(quit, 1.15, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)

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
