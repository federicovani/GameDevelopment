class_name HotkeyRebindButton extends Control

@onready var label : Label = $HBoxContainer/Label
@onready var button : Button = $HBoxContainer/Button

@export var action_name : String = "move_left"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

func set_action_name():
	label.text = "Unassigned"
	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"
		"attack":
			label.text = "Attack"

func set_text_for_key():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode
