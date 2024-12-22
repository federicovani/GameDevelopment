class_name jumping extends State

@export var falling_state : State

@export var jump_start_animation : String = "jump_start"

func on_enter():
	playback.travel(jump_start_animation)

func state_process(delta):
	if(character.velocity.y > 0):
		next_state = falling_state
