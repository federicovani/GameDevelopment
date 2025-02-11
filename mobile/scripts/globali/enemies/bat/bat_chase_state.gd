class_name bat_chase extends State

@onready var timer: Timer = $Timer

@export var chase_area : Area2D
@export var player : CharacterBody2D

var chase_speed : float = 2000.0

func _ready() -> void:
	player = Global.playerBody

func on_enter():
	playback.travel(character.walk_animation)
	timer.start()

func _physics_process(delta: float) -> void:
	if (get_parent().current_state == self):
		if !character.ray_cast_down.is_colliding():
			character.direction = character.position.direction_to(player.global_position)
			character.velocity = character.direction * chase_speed * delta
		else:
			character.direction = character.position.direction_to(player.global_position)
			#Migliorabile
			character.direction.y = Vector2.UP.y
			character.velocity = character.direction * chase_speed * delta

func _on_timer_timeout() -> void:
	if !chase_area.has_overlapping_bodies():
		next_state = character.walk_state
	else:
		timer.start()

func on_exit():
	timer.stop()
