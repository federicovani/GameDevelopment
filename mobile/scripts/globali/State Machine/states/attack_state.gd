class_name attack extends State

@export var sprite : SpriteAttackOffset

func on_enter():
	playback.travel(character.attack_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(get_parent().current_state == self && anim_name == character.attack_animation):
		next_state = character.chase_state

#Handled by the AnimationPlayer, fix the offset if the sprite is not centered during the attack animation
func set_attack_offset():
	if character.facing_right:
		sprite.offset = sprite.facing_right_offset
	else:
		sprite.offset = sprite.facing_left_offset

#Handled by the AnimationPlayer, reset the offset after the attack animation
func reset_offset():
	sprite.offset = sprite.default_offset

func on_exit():
	reset_offset()
