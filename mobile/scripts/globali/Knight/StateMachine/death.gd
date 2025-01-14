extends State

@onready var timer: Timer = $Timer

func on_enter():
	playback.travel(character.death_animation)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.death_animation):
		timer.start()

func _on_timer_timeout() -> void:
	character.idle_state.set_collision_shapes()
	get_tree().reload_current_scene()
