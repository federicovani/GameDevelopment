extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	#body.get_node("CollisionShape2D").queue_free()
	if body.has_method("die"):
		body.die()
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
