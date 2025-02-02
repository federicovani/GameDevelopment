extends RigidBody2D

@export var push_force: float = 100.0


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.playerBody:
		var direction = sign(body.velocity.x)  # Direzione del giocatore
		linear_velocity = Vector2(push_force * direction, linear_velocity.y)  # Imposta la velocità orizzontale
