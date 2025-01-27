class_name PauseMenu extends Control

@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var menu_container: MarginContainer = $MenuContainer
@onready var open_button: Button = $openButtonContainer/openButton

var paused : bool = false
var opened_option_menu : bool = false

func _ready() -> void:
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	menu_container.visible = false
	open_button.visible = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") && !opened_option_menu:
		pause_menu()

func pause_menu():
	#Already in pause, hide the menu
	if paused:
		open_button.show()
		menu_container.hide()
		get_tree().paused = false
	#Not in pause, show the menu
	else:
		get_tree().paused = true
		open_button.hide()
		menu_container.show()
	paused = !paused


func _on_open_button_pressed() -> void:
	pause_menu()

func _on_resume_pressed() -> void:
	pause_menu()

func _on_options_button_down() -> void:
	opened_option_menu = true
	menu_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_options_menu():
	if opened_option_menu:
		menu_container.visible = true
		options_menu.visible = false
		opened_option_menu = false

func _on_quit_pressed() -> void:
	get_tree().quit()
