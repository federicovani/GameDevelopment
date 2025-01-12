class_name crouch_attack extends State

@export var is_crouching : bool

func on_enter():
	playback.travel(character.crouch_attack_animation)
	is_crouching = true

func state_input(event: InputEvent):
	if(event.is_action_pressed("crouch")):
		is_crouching = true
	if(event.is_action_released("crouch")):
		is_crouching = false

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.crouch_attack_animation):
		if is_crouching:
			next_state = character.crouch_state
		else:
			next_state = character.idle_state
