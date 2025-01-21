extends State

func on_enter():
	choose_attack()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(get_parent().current_state == self && (anim_name == character.attack1_animation || anim_name == character.attack2_animation)):
		next_state = character.chase_state

func choose_attack():
	if(character.attack_type == 1):
		playback.travel(character.attack1_animation)
	else:
		playback.travel(character.attack2_animation)
