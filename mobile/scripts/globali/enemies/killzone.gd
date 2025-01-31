extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(_body: Node2D) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	SignalBus.emit_forced_death()
