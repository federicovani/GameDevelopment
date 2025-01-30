class_name bat_chase extends State

@onready var timer: Timer = $Timer

@export var player : CharacterBody2D

var chase_speed : float = 2000.0

func on_enter():
	playback.travel(character.walk_animation)
	timer.start()

func _physics_process(delta: float) -> void:
	player = Global.playerBody
	if (get_parent().current_state == self):
		if !character.ray_cast_down.is_colliding():
			character.direction = character.position.direction_to(player.position)
			character.velocity = character.direction * chase_speed * delta
		else:
			character.direction = character.position.direction_to(player.position)
			#Migliorabile
			character.direction.y = Vector2.UP.y
			character.velocity = character.direction * chase_speed * delta
		character.move_and_slide()

func _on_timer_timeout() -> void:
	next_state = character.walk_state

func on_exit():
	timer.stop()
