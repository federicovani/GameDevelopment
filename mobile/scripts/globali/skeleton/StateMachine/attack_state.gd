class_name attack extends State

func on_enter():
	playback.travel(character.attack_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.attack_animation):
		next_state = character.chase_state
