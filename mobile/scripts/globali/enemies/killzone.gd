extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	SignalBus.emit_new_death()
	SignalBus.emit_camera_shook(2)
	SignalBus.emit_on_health_decreased()
	SignalBus.emit_show_game_over_screen()
