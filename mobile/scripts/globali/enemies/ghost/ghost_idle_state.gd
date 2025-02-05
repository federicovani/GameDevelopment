extends State

func on_enter():
	playback.travel(character.idle_animation)

func state_process(delta):
	character.velocity = Vector2.ZERO

func _on_appear_zone_body_entered(body: Node2D) -> void:
	if(get_parent().current_state == self):
		if body == Global.playerBody:
			character.fade_in()
			next_state = character.chase_state
