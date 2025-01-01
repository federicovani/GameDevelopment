class_name falling extends State

func on_enter():
	playback.travel(character.jump_between_animation)

func state_process(_delta):
	if(character.is_on_floor()):
		next_state = character.idle_state
