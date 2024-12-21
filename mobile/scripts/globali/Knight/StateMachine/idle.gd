class_name idle extends State

@export var jump_velocity: float = -300.0
@export var jumping_state: State
@export var falling_state : State
@export var jump_animation: String = "jump_start"
@export var falling_animation: String = "jump_end"

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = falling_state
		
func on_exit():
	if(next_state == falling_state):
		playback.travel(falling_animation )

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = jumping_state
	playback.travel(jump_animation)
