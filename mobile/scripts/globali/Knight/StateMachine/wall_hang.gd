class_name wall_hang extends State

func on_enter():
	playback.travel(character.wall_hang_animation)

#func state_input(event: InputEvent):
	#if(event.is_action_pressed("jump")):
		#playback.travel(character.wall_climb_animation)
		##next_state = character.idle_state
	#if(event.is_action_pressed("crouch")):
		#next_state = character.falling_state
