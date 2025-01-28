class_name HotkeyRebindButton extends Control

@onready var label: Label = $MarginContainer/MarginContainer/HBoxContainer/Label
@onready var button: Button = $MarginContainer/MarginContainer/HBoxContainer/Button

@export var setting_tab_container : SettingTabContainer

@export var action_name : String = "move_left"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	load_keybinds()

func _process(_delta: float) -> void:
	update_button_scale()

func load_keybinds():
	rebind_action_key(SettingsDataContainer.get_keybind(action_name))

func set_action_name():
	label.text = "Unassigned"
	match action_name:
		"move_left":
			label.text = "Move Left"
		"move_right":
			label.text = "Move Right"
		"jump":
			label.text = "Jump"
		"crouch":
			label.text = "Crouch"
		"dash":
			label.text = "Dash"
		"attack":
			label.text = "Attack"

func set_text_for_key():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode


func _on_button_toggled(button_pressed: bool) -> void:
	if button_pressed:
		setting_tab_container.keybinding = true
		button.text = "Press any key..."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false

func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name,event)
	SettingsDataContainer.set_keybind(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
	
	setting_tab_container.keybinding = false
	#var is_duplicate=false
	#var action_event=event
	#var action_keycode=OS.get_keycode_string(action_event.physical_keycode)
	#for i in get_tree().get_nodes_in_group("hotkey_button"):
			#if i.action_name!=self.action_name:
				#if i.button.text=="%s" %action_keycode:
					#is_duplicate=true
					#self.button.text = "Already Bound"
					#await get_tree().create_timer(2.0).timeout
					#set_process_unhandled_key_input(false)
					#set_text_for_key()
					#break
	#if not is_duplicate:
		#InputMap.action_erase_events(action_name)
		#InputMap.action_add_event(action_name,event)
		#SettingsDataContainer.set_keybind(action_name, event)
		#
		#set_process_unhandled_key_input(false)
		#set_text_for_key()
		#set_action_name()

func update_button_scale():
	button_hover(button, 1.1, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)
