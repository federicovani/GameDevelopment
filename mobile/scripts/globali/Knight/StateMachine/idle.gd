class_name idle extends State

@onready var buffer_timer: Timer = $BufferTimer

@export var jumping_state: State
@export var falling_state : State
@export var attack_state : State
@export var death_state : State

@export var idle_animation: String = "move"
@export var jump_animation: String = "jump_start"
@export var falling_animation: String = "jump_end"

@export var jump_velocity: float = -300.0

func on_enter():
	playback.travel(idle_animation)

func state_process(delta):
	if(!character.is_on_floor() && buffer_timer.is_stopped()):
		next_state = falling_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("attack")):
		attack()

func jump():
	character.velocity.y = jump_velocity
	next_state = jumping_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
