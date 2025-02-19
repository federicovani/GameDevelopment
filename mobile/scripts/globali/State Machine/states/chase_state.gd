class_name chase extends State

@onready var timer: Timer = $Timer

@export var attack_zone : Area2D
@export var player : CharacterBody2D

func _ready() -> void:
	player = Global.playerBody
	
func on_enter():
	timer.start()

func state_process(delta):
	if get_parent().check_if_can_move():
		character.direction = character.position.direction_to(player.global_position)
		character.velocity.x = character.direction.x * character.chase_speed * delta
		if !character.ray_cast_down.is_colliding():
			character.direction.x = -character.direction.x
			character.velocity.x = character.direction.x * character.chase_speed * delta
			next_state = character.walk_state

func _on_timer_timeout() -> void:
	if !attack_zone.has_overlapping_bodies():
		next_state = character.walk_state
	else:
		timer.start()

func on_exit():
	timer.stop()
