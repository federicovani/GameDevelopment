extends Area2D

@export var teleport_position: Vector2 = Vector2(6653, 107)

func _on_body_entered(body: Node2D) -> void:
	if (body == Global.playerBody):
		await get_tree().create_timer(1.0).timeout  # Aspetta 1 secondo
		body.position = teleport_position
