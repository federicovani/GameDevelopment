class_name jumping extends State

@onready var buffer_timer: Timer = $BufferTimer

var released : bool = false

func on_enter():
	buffer_timer.start()
	character.velocity.y = character.jump_velocity
	released = false
	playback.travel(character.jump_start_animation)
	character.update_player_audio(character.jump_sfx)

func state_process(_delta):
	if(character.velocity.y > 0):
		next_state = character.falling_state
	if(buffer_timer.is_stopped() && character.is_on_floor()):
		next_state = character.idle_state

func state_input(event: InputEvent):
	#Different jump heights based on the time the space bar is pressed
	if(!released && event.is_action_released("jump")):	
		character.velocity.y = character.jump_velocity/4
		released = true
