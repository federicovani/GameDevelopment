class_name walk extends State

@export var direction : Vector2
@export var starting_move_direction : Vector2 = Vector2.RIGHT

func _ready() -> void:
	direction = starting_move_direction

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	
	if direction && get_parent().check_if_can_move() && get_parent().current_state != character.chase_state:
		#Change direction if the enemy collide with a wall
		if character.ray_cast_right.is_colliding():
			direction = Vector2.LEFT
			character.flip_orientation(true)
		if character.ray_cast_left.is_colliding():
			direction = Vector2.RIGHT
			character.flip_orientation(false)
		character.velocity.x = direction.x * character.movement_speed * delta
	elif get_parent().current_state != character.hit_state:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_speed)

	character.move_and_slide()
