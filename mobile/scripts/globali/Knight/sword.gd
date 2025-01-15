extends Area2D

@export var player : Knight
@export var facing_collision_shape : FacingCollisionShape

func _ready():
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is damageable:
			#Get direction from the sword to the body
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			if(direction_sign > 0):
				child.hit(get_parent().damage, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(get_parent().damage, Vector2.LEFT)
			else:
				child.hit(get_parent().damage, Vector2.ZERO)
