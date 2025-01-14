class_name bat_flying extends State

var rng = RandomNumberGenerator.new()

var directions : Array = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

func on_enter():
	playback.travel(character.walk_animation)

func _physics_process(delta: float) -> void:
	if(get_parent().current_state == self):
		if(get_parent().check_if_can_move()):
			if character.ray_cast_down.is_colliding():
				character.direction.y = Vector2.UP.y
			if character.ray_cast_up.is_colliding():
				next_state = character.sleep_state
			if character.ray_cast_left.is_colliding():
				character.direction.x = Vector2.RIGHT.x
			if character.ray_cast_right.is_colliding():
				character.direction.x = Vector2.LEFT.x
			character.velocity += character.direction * character.movement_speed * delta
		character.move_and_slide()

#Every .1 to 1 seconds (random number) the character changes direction
func _on_direction_timer_timeout() -> void:
	if (get_parent().current_state == self):
		$DirectionTimer.wait_time = rng.randf_range(0.1, 1)
		character.direction = directions.pick_random()

func _on_chase_area_body_entered(_body: Node2D) -> void:
	next_state = character.chase_state
