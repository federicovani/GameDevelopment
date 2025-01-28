extends Control

@onready var back: Button = $MarginContainer/VBoxContainer/MarginContainer/MarginContainer/LevelContainer/VBoxContainer/HBoxContainer/Back
@onready var next: Button = $MarginContainer/VBoxContainer/MarginContainer/MarginContainer/LevelContainer/VBoxContainer/HBoxContainer/Next
@onready var start: Button = $MarginContainer/VBoxContainer/MarginContainer/MarginContainer/LevelContainer/VBoxContainer/Start
@onready var main_menu: Button = $MarginContainer/VBoxContainer/MainMenu

var current_level_selected : int = 0

@export var levels : Array[VBoxContainer]

func _ready() -> void:
	update_level_selection()

func _process(_delta: float) -> void:
	update_button_scale()

func _on_next_pressed() -> void:
	if(current_level_selected + 1 < levels.size()):
		current_level_selected += 1
	else:
		current_level_selected = 0
	update_level_selection()

func _on_back_pressed() -> void:
	if(current_level_selected == 0):
		current_level_selected = levels.size() - 1
	else:
		current_level_selected -= 1
	update_level_selection()

func _on_start_pressed() -> void:
	SceneManager.go_to_scene(levels[current_level_selected].name)

func _on_main_menu_pressed() -> void:
	SceneManager.go_to_main_menu()

func update_level_selection():
	for i in levels.size():
		if(i == current_level_selected):
			levels[i].show()
			if(SceneManager.is_level_unlocked(levels[i].name)):
				start.disabled = false
				start.text = "Start"
			else:
				start.disabled = true
				start.text = "Level Locked"
		else:
			levels[i].hide()

func update_button_scale():
	button_hover(start, 1.2, 0.2)
	button_hover(next, 1.3, 0.2)
	button_hover(back, 1.3, 0.2)
	button_hover(main_menu, 1.1, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)
