class_name chase extends State

@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	player = Global.playerBody
	if (get_parent().current_state == self):
		if not character.is_on_floor():
			character.velocity += character.get_gravity() * delta
		if get_parent().check_if_can_move():
			character.direction = character.position.direction_to(player.position) * character.movement_speed * delta
			character.velocity.x = character.direction.x
		character.move_and_slide()
