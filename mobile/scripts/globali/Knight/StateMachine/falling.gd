class_name falling extends State

@export var idle_state : State
@export var idle_animation_name : String = "move"

func state_process(delta):
	if(character.is_on_floor()):
		next_state = idle_state

func on_exit():
	if(next_state == idle_state):
		playback.travel(idle_animation_name)
