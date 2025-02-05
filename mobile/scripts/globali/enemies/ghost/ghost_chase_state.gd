class_name ghost_chase extends State

@export var player : CharacterBody2D

var chase_speed : float = 2000.0

#func on_enter():
	#playback.travel(character.walk_animation)

func _physics_process(delta: float) -> void:
	player = Global.playerBody
	if (get_parent().current_state == self):
		character.direction = character.position.direction_to(player.position)
		if(!is_player_looking()):
			character.velocity = character.direction * chase_speed * delta
		else:
			character.velocity = Vector2.ZERO

func is_player_looking() -> bool:
	return ((character.facing_right == !player.facing_right) || (!character.facing_right == player.facing_right))
	
