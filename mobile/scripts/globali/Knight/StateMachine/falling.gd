class_name falling extends State

@export var is_crouching : bool

func on_enter():
	playback.travel(character.jump_between_animation)
	is_crouching = false

func state_input(event: InputEvent):
	if(event.is_action_pressed("crouch")):
		is_crouching = true
	if(event.is_action_released("crouch")):
		is_crouching = false

func state_process(_delta):
	if(character.is_on_floor()):
		if is_crouching:
			playback.travel(character.crouch_transition_animation)
			next_state = character.crouch_state
		else:
			next_state = character.idle_state

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !character.is_on_floor():
		character.velocity.y += character.gravity * delta
