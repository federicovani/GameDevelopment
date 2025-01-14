class_name bat_chase extends State

@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	player = Global.playerBody
	if (get_parent().current_state == self):
		character.direction = character.position.direction_to(player.position)
		character.velocity = character.direction * character.movement_speed * delta
		#if !character.ray_cast_down.is_colliding():
			#character.direction.x = -character.direction.x
			#character.velocity.x = character.direction.x * character.movement_speed * delta
			#next_state = character.walk_state
		character.move_and_slide()
