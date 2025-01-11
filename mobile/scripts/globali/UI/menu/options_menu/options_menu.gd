class_name OptionsMenu extends Control

@onready var settings_tab_container: SettingTabContainer = $MarginContainer/VBoxContainer/SettingsTabContainer

signal exit_options_menu

func _ready() -> void:
	#Cant do anything before the process is set to true, prevent bugs and ghost buttons
	settings_tab_container.exit_options_menu.connect(on_exit_button_down)
	set_process(false)

func on_exit_button_down() -> void:
	exit_options_menu.emit()
	#Save all the settings
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)
