class_name UIControl extends Control

@onready var game_over: Control = $GameOverScreen
@onready var retry_button : Button = $GameOverScreen/VBoxContainer/Retry
@onready var title_button: Button = $GameOverScreen/VBoxContainer/BackToTitle
@onready var game_over_animation_player: AnimationPlayer = $GameOverScreen/AnimationPlayer

@export var hearths : Array[Node]
@export var coin_label : Label

@onready var level_completed: Control = $LevelCompletedScreen
@onready var level_completed_animation_player: AnimationPlayer = $LevelCompletedScreen/AnimationPlayer
@export var diamonds_array : Array[Node]
@onready var time_label: Label = $LevelCompletedScreen/MarginContainer/VBoxContainer/Time
@onready var level_coin_label: Label = $LevelCompletedScreen/MarginContainer/VBoxContainer/Coin
@onready var death_label: Label = $LevelCompletedScreen/MarginContainer/VBoxContainer/Death
@onready var next_level_button: Button = $LevelCompletedScreen/MarginContainer/VBoxContainer/Buttons/NextLevel
@onready var main_menu_button: Button = $LevelCompletedScreen/MarginContainer/VBoxContainer/Buttons/MainMenu



func _ready() -> void:
	SignalBus.connect("update_coin_label", _on_update_coin_label)
	SignalBus.connect("update_hearth_label", _on_update_hearth_label)
	SignalBus.connect("show_game_over_screen", _on_show_game_over_screen)
	SignalBus.connect("update_level_stats_ui", _on_update_level_stats_ui)
	
	next_level_button.pressed.connect(next_level)
	main_menu_button.pressed.connect(main_menu)
	hide_level_completed_screen()
	
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

func _on_update_level_stats_ui(time : float, deaths : int, coins : int, diamonds : int):
	#Diamonds:
	for i in 3:
		if(i < diamonds):
			diamonds_array[i].show()
			diamonds_array[i+3].hide()
		else:
			diamonds_array[i].hide()
			diamonds_array[i+3].show()
	
	#Time
	time_label.text = "Time: " + time_convert(time)
	#Deaths
	death_label.text = "Deaths: " + str(deaths)
	#Coins
	level_coin_label.text = "Coins: " + str(coins)
	
	show_level_completed_screen()

func time_convert(time : int):
	var seconds = time%60
	var minutes = (time/60)%60
	
	#returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]

func show_level_completed_screen():
	level_completed.visible = true
	level_completed.mouse_filter = Control.MOUSE_FILTER_STOP
	
	level_completed_animation_player.play("show_level_completed")
	await level_completed_animation_player.animation_finished
	next_level_button.grab_focus()

func next_level():
	await level_completed_fade_to_black()
	#Next level function

func main_menu():
	await level_completed_fade_to_black()
	get_tree().change_scene_to_file("res://scenes/globali/UI/menu/main_menu.tscn")

func level_completed_fade_to_black():
	level_completed_animation_player.play("fade_to_black")
	await level_completed_animation_player.animation_finished
	return true

func hide_level_completed_screen():
	level_completed.visible = false
	level_completed.mouse_filter = Control.MOUSE_FILTER_IGNORE
	level_completed.modulate = Color.TRANSPARENT


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
