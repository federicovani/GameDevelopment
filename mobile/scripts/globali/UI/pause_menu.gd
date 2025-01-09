class_name PauseMenu extends Control

var paused : bool = false

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu()

func pause_menu():
	if paused:
		hide()
		#Engine.time_scale = 1
		get_tree().paused = false
	else:
		get_tree().paused = true
		#Engine.time_scale = 0
		show()
	paused = !paused

func _on_resume_pressed() -> void:
	pause_menu()

func _on_quit_pressed() -> void:
	get_tree().quit()
	
