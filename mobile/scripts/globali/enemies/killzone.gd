extends Area2D

var player: CharacterBody2D = null

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
