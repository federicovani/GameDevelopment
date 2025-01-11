class_name OptionsMenu extends Control

signal exit_options_menu

func _ready() -> void:
	#Cant do anything before the process is set to true, prevent bugs and ghost buttons
	set_process(false)

func _on_exit_button_down() -> void:
	exit_options_menu.emit()
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	set_process(false)
