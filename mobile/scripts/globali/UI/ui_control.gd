class_name UIControl extends Control

@onready var game_over: Control = $GameOverScreen
@onready var retry_button : Button = $GameOverScreen/VBoxContainer/Retry
@onready var title_button: Button = $GameOverScreen/VBoxContainer/BackToTitle
@onready var game_over_animation_player: AnimationPlayer = $GameOverScreen/AnimationPlayer

@export var hearths : Array[Node]
@export var coin_label : Label

func _ready() -> void:
	SignalBus.connect("update_coin_label", _on_update_coin_label)
	SignalBus.connect("update_hearth_label", _on_update_hearth_label)
	SignalBus.connect("show_game_over_screen", _on_show_game_over_screen)
	retry_button.pressed.connect(retry_game)
	title_button.pressed.connect(title_screen)
	hide_game_over_screen()
	coin_label.text = str(0)

func _on_update_coin_label(value : int):
	coin_label.text = str(value)

func _on_update_hearth_label(current_hearth_amount : int):
	for i in 3:
		if(i < current_hearth_amount):
			hearths[i].show()
			hearths[i+3].hide()
		else:
			hearths[i].hide()
			hearths[i+3].show()

func _on_show_game_over_screen():
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	game_over_animation_player.play("show_game_over")
	await game_over_animation_player.animation_finished
	
	retry_button.grab_focus()

func retry_game():
	await game_over_fade_to_black()
	get_tree().reload_current_scene()

func title_screen():
	await game_over_fade_to_black()
	get_tree().change_scene_to_file("res://scenes/globali/UI/menu/main_menu.tscn")

func game_over_fade_to_black() -> bool:
	game_over_animation_player.play("fade_to_black")
	await game_over_animation_player.animation_finished
	return true

func hide_game_over_screen():
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color.TRANSPARENT
