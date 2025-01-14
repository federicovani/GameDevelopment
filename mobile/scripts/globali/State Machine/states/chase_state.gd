class_name chase extends State

@onready var timer: Timer = $Timer

@export var player : CharacterBody2D

func state_process(delta):
	player = Global.playerBody
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	if get_parent().check_if_can_move():
		character.direction = character.position.direction_to(player.position)
		character.velocity.x = character.direction.x * character.movement_speed * delta
		if !character.ray_cast_down.is_colliding():
			character.direction.x = -character.direction.x
			character.velocity.x = character.direction.x * character.movement_speed * delta
			next_state = character.walk_state
	character.move_and_slide()

func _on_timer_timeout() -> void:
	next_state = character.walk_state
