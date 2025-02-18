class_name MainMenu extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer
@onready var transition_controller: SceneTransitionController = $TransitionController

@onready var start: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Start
@onready var login: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/LogIn
@onready var options: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Options
@onready var quit: Button = $MarginContainer/VBoxContainer/ButtonsContainer/VBoxContainer/Quit

func _ready() -> void:
	transition_controller.fade_in(0.5)
	
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	
	if Firebase.Auth.check_auth_file():
		login.text = "Logout"

func _process(_delta: float) -> void:
	update_button_scale()

func update_button_scale():
	button_hover(start, 1.15, 0.2)
	button_hover(options, 1.15, 0.2)
	button_hover(quit, 1.15, 0.2)
	button_hover(login, 1.15, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)

func _on_start_button_down() -> void:
	transition_controller.fade_out(0.5)
	await transition_controller.animation_player.animation_finished
	
	SceneManager.go_to_scene(SceneManager.level_selector)

func _on_options_button_down() -> void:
	transition_controller.fade_out(0.5)
	await transition_controller.animation_player.animation_finished
	
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
	
	transition_controller.fade_in(0.5)

func on_exit_options_menu():
	transition_controller.fade_out(0.5)
	await transition_controller.animation_player.animation_finished
	
	margin_container.visible = true
	options_menu.visible = false
	
	transition_controller.fade_in(0.5)

func _on_quit_button_down() -> void:
	animation_player.play("quit_animation")
	await animation_player.animation_finished
	get_tree().quit()
	
	
func _on_log_in_pressed() -> void:
	if login.text == "Login":
		transition_controller.fade_out(0.5)
		await transition_controller.animation_player.animation_finished
		
		SceneManager.go_to_scene(SceneManager.login_page)
	elif login.text == "Logout":
		Firebase.Auth.logout()
		login.text = "Login"
