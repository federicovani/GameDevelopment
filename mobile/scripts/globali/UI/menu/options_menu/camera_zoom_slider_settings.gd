extends Control

@onready var slider: HSlider = $MarginContainer/MarginContainer/HBoxContainer/HSlider
@onready var zoom_value: Label = $MarginContainer/MarginContainer/HBoxContainer/ZoomValue
@onready var reset_button: Button = $MarginContainer/MarginContainer/HBoxContainer/ResetButton

func _ready() -> void:
	set_zoom_value_label()

func _on_h_slider_value_changed(value: float) -> void:
	SettingsSignalBus.emit_on_camera_zoom_edited(value)
	set_zoom_value_label()

func set_zoom_value_label():
	zoom_value.text = str(slider.value)


func _on_reset_button_pressed() -> void:
	pass # Replace with function body.
