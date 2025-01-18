class_name crouch_attack extends State

func on_enter():
	playback.travel(character.crouch_attack_animation)
	character.update_player_audio(character.attack1_sfx)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.crouch_attack_animation):
		if character.is_crouching || !character.crouch_state.can_standup():
			next_state = character.crouch_state
		else:
			next_state = character.idle_state

	
