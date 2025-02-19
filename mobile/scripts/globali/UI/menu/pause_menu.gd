class_name PauseMenu extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var buffer_timer: Timer = $BufferTimer
@onready var transition_controller: SceneTransitionController = $TransitionController

@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var menu_container: MarginContainer = $MenuContainer
@onready var blur_background: MarginContainer = $BlurBackground

@onready var open_button: Button = $openButtonContainer/openButton
@onready var resume_button: Button = $MenuContainer/Menu/VBoxContainer/Resume
@onready var options_button: Button = $MenuContainer/Menu/VBoxContainer/Options
@onready var quit_button: Button = $MenuContainer/Menu/VBoxContainer/Quit

var pause_menu_buttons : Array
var options_menu_buttons : Array

var paused : bool = false
var opened_option_menu : bool = false

func _ready() -> void:
	transition_controller.fade_in(0.5)
	
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	pause_menu_buttons = [resume_button, options_button, quit_button]
	menu_container.visible = false
	blur_background.visible = false
	open_button.visible = true

func _process(_delta: float) -> void:
	update_button_scale()
	if Input.is_action_just_pressed("pause") && buffer_timer.is_stopped() && !opened_option_menu:
		pause_menu()

func update_button_scale():
	for button in pause_menu_buttons:
		button_hover(button, 1.1, 0.2)
		
	button_hover(open_button, 1.3, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)

func pause_menu():
	buffer_timer.start()
	#Already in pause, hide the menu
	if paused:
		animation_player.play("close_pause_menu")
		await animation_player.animation_finished
		open_button.show()
		blur_background.hide()
		menu_container.hide()
		get_tree().paused = false
	#Not in pause, show the menu
	else:
		get_tree().paused = true
		animation_player.play("open_pause_menu")
		await animation_player.animation_finished
		open_button.hide()
		blur_background.show()
		menu_container.show()
	paused = !paused


func _on_open_button_pressed() -> void:
	pause_menu()

func _on_resume_pressed() -> void:
	pause_menu()

func _on_options_button_down() -> void:
	opened_option_menu = true
	animation_player.play("open_options_menu")
	await animation_player.animation_finished
	menu_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_options_menu():
	if opened_option_menu:
		animation_player.play("close_options_menu")
		await animation_player.animation_finished
		menu_container.visible = true
		options_menu.visible = false
		opened_option_menu = false

func _on_quit_pressed() -> void:
	transition_controller.fade_out(0.5)
	await transition_controller.animation_player.animation_finished
	get_tree().paused = false
	SceneManager.go_to_main_menu()
