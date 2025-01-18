class_name attacking extends State

@onready var timer: Timer = $Timer

func on_enter():
	playback.travel(character.attack1_animation)
	character.update_player_audio(character.attack1_sfx)

func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		#Timer for the attack combo
		timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.attack1_animation):
		if(timer.is_stopped()):
			if !character.is_crouching:
				next_state = character.idle_state
				playback.travel(character.idle_animation)
			else:
				next_state = character.crouch_state
				playback.travel(character.crouch_transition_animation)
		else:
			playback.travel(character.attack2_animation)
			character.update_player_audio(character.attack2_sfx)
	if(anim_name == character.attack2_animation):
		if !character.is_crouching:
			next_state = character.idle_state
			playback.travel(character.idle_animation)
		else:
			next_state = character.crouch_state
			playback.travel(character.crouch_transition_animation)
