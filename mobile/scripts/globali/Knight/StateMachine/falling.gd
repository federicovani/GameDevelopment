class_name falling extends State

@export var idle_state : State

@export var jump_between_animation : String = "jump_in_between"

func on_enter():
	playback.travel(jump_between_animation)

func state_process(delta):
	if(character.is_on_floor()):
		next_state = idle_state
