extends Area2D

@export var damage : int = 5

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
			if is_instance_valid(child) && child is damageable:
				child.hit(damage, Vector2.ZERO)
