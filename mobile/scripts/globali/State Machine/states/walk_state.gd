class_name walk extends State

@onready var buffer_timer: Timer = $BufferTimer

var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	if (get_parent().current_state == self):
		# Add the gravity.
		if not character.is_on_floor():
			character.velocity += character.get_gravity() * delta
		
		if character.direction && get_parent().check_if_can_move():
			#Change direction if the enemy collide with a wall
			if character.ray_cast_right.is_colliding():
				character.direction = Vector2.LEFT
			if character.ray_cast_left.is_colliding():
				character.direction = Vector2.RIGHT
			if character.is_on_floor() && buffer_timer.is_stopped() && !character.ray_cast_down.is_colliding():
				character.direction.x = -character.direction.x
				#Prevent the enemy from spam-changing direction
				buffer_timer.start()
			character.velocity.x = character.direction.x * character.movement_speed * delta
		elif get_parent().current_state != character.hit_state:
			character.velocity.x = move_toward(character.velocity.x, 0, character.movement_speed)

#Every 3 to 10 seconds (random number) the character changes direction
func _on_direction_timer_timeout() -> void:
	if (get_parent().current_state == self):
		$DirectionTimer.wait_time = rng.randi_range(5, 10)
		character.direction.x = -character.direction.x
