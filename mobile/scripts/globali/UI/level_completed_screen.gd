extends Control

@onready var next_level: Button = $MarginContainer/VBoxContainer/Buttons/NextLevel

func _ready() -> void:
	if(SceneManager.get_next_level(SceneManager.current_level) == "game_ended"):
		next_level.visible = false
	else:
		next_level.visible = true
