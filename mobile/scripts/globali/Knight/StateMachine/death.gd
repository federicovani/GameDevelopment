class_name death extends State

@onready var timer: Timer = $Timer

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.death_animation):
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
