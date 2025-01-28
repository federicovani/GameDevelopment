class_name OptionsDisplayButton extends Control

@onready var option_button: OptionButton = $MarginContainer/MarginContainer/HBoxContainer/OptionButton

func _process(_delta: float) -> void:
	update_button_scale()

func update_button_scale():
	button_hover(option_button, 1.05, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)
