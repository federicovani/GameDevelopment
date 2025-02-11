class_name death extends State

@onready var timer: Timer = $Timer

func on_enter():
	playback.travel(character.death_animation)
	SignalBus.emit_camera_shook()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == character.death_animation):
		timer.start()
		await timer.timeout
		#Character is finished dying, remove from the game
		character.queue_free()
