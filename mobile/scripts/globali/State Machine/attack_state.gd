class_name attack extends State

#Minimum seconds between two attacks
@onready var buffer: Timer = $BufferTimer

@export var attack_zone: Area2D
@export var sprite : SpriteAttackOffset

func on_enter():
	#set_attack_offset()
	playback.travel(character.attack_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.attack_animation):
		#If the player left the attack zone then go in chase state
		if(!attack_zone.has_overlapping_bodies()):
			next_state = character.chase_state
		else:
			#reset_offset()
			buffer.start()

func _on_buffer_timer_timeout() -> void:
	#If the player left the attack zone then go in chase state, else hit him again and return in attack state
	if(!attack_zone.has_overlapping_bodies()):
		next_state = character.chase_state
	else:
		next_state = self

func set_attack_offset():
	if character.facing_right:
		sprite.offset = sprite.facing_right_offset
	else:
		sprite.offset = sprite.facing_left_offset

func reset_offset():
	sprite.offset = sprite.default_offset

#func on_exit():
	#reset_offset()
