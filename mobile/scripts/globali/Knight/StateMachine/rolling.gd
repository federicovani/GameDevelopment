class_name rolling extends State


func on_enter():
	playback.travel(character.roll_animation)

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = character.falling_state
	if get_parent().check_if_can_move():
			character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
			
			if character.direction && get_parent().check_if_can_move():
				character.velocity.x = character.direction.x * character.crouching_speed * delta
			else:
				character.velocity.x = move_toward(character.velocity.x, 0, character.crouching_speed)
				
			character.move_and_slide()


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.roll_animation):
		if character.is_crouching:
			playback.travel(character.crouch_transition_animation)
			next_state = character.crouch_state
		else:
			next_state = character.idle_state
