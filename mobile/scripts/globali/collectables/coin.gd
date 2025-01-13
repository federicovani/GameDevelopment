extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	SignalBus.emit_on_coin_collected(1)
	queue_free()
