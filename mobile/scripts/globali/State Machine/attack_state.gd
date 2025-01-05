class_name attack extends State

@export var attack_zone: Area2D
@export var sprite : SpriteAttackOffset

func on_enter():
	set_attack_offset()
	playback.travel(character.attack_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.attack_animation):
		if(attack_zone.exited):
			next_state = character.chase_state
		else:
			attack_zone.hit()
			next_state = self
			
func set_attack_offset():
	if character.facing_right:
		sprite.offset = sprite.facing_right_offset
	else:
		sprite.offset = sprite.facing_left_offset

func reset_offset():
	sprite.offset = sprite.default_offset

func on_exit():
	reset_offset()
