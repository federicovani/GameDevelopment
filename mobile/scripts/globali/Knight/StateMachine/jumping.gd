class_name jumping extends State

func on_enter():
	playback.travel(character.jump_start_animation)

func state_process(delta):
	if(character.velocity.y > 0):
		next_state = character.falling_state
