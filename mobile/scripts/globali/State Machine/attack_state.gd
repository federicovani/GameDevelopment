class_name attack extends State

@export var attack_zone: Area2D

func on_enter():
	playback.travel(character.attack_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.attack_animation):
		if(attack_zone.exited):
			next_state = character.chase_state
		else:
			attack_zone.hit()
			next_state = self
