extends State

var array : Array = [1, 2]

func on_enter():
	random_attack_animation()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(get_parent().current_state == self && (anim_name == character.attack1_animation || anim_name == character.attack2_animation)):
		next_state = character.chase_state

func random_attack_animation():
	var random = array.pick_random()
	if(random == 1):
		playback.travel(character.attack1_animation)
	else:
		playback.travel(character.attack2_animation)
