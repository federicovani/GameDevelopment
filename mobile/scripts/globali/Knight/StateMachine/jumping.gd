class_name jumping extends State

@export var falling_state : State
@export var jump_between_animation : String = "jump_in_between"

func state_process(delta):
	if(character.velocity.y > 0):
		next_state = falling_state
		
func on_exit():
	if(next_state == falling_state):
		playback.travel(jump_between_animation)
