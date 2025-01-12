class_name falling extends State

func on_enter():
	playback.travel(character.jump_between_animation)

func state_process(_delta):
	if(character.is_on_floor()):
		if character.is_crouching:
			playback.travel(character.crouch_transition_animation)
			next_state = character.crouch_state
		else:
			next_state = character.idle_state

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !character.is_on_floor():
		character.velocity.y += character.gravity * delta
