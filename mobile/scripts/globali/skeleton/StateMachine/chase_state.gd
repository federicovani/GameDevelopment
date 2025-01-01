class_name chase extends State

@onready var timer: Timer = $Timer

@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	player = Global.playerBody
	if (get_parent().current_state == self):
		if not character.is_on_floor():
			character.velocity += character.get_gravity() * delta
		if get_parent().check_if_can_move():
			character.direction = character.position.direction_to(player.position) * character.movement_speed * delta
			character.velocity.x = character.direction.x
			print_debug(character.direction.x)
			if !character.ray_cast_down.is_colliding():
				print_debug(character.direction.x)
				next_state = character.walk_state
				character.direction.x = -character.direction.x
				character.velocity.x = character.direction.x * character.movement_speed * delta
				print_debug(character.direction.x)
		character.move_and_slide()

func _on_timer_timeout() -> void:
	next_state = character.walk_state
