class_name OptionsMenu extends Control

@onready var settings_tab_container: SettingTabContainer = $MarginContainer/VBoxContainer/SettingsTabContainer
@onready var exit: Button = $MarginContainer/VBoxContainer/Exit

signal exit_options_menu

func _ready() -> void:
	#Cant do anything before the process is set to true, prevent bugs and ghost buttons
	settings_tab_container.exit_options_menu.connect(on_exit_button_down)
	set_process(false)

func _process(_delta: float) -> void:
	update_button_scale()

func update_button_scale():		
	button_hover(exit, 1.3, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)

func on_exit_button_down() -> void:
	exit_options_menu.emit()
	SignalBus.emit_update_tutorial_keybinds_labels()
	#Save all the settings
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)
