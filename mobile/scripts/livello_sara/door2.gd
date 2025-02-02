extends Area2D

@export var fade_duration: float = 1.0  # Durata della dissolvenza

func _on_body_exited(body: Node2D) -> void:
	if body == Global.playerBody:
		fade_out()

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_duration)  # Dissolvenza
	await tween.finished  # Aspetta che la dissolvenza sia completata
	queue_free()  # Rimuove la porta dalla scena
