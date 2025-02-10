extends State

@export var awakening_zone : Area2D
@export var attack_zone_collision_shape : CollisionShape2D

@export var lights: Node2D

func _ready() -> void:
	attack_zone_collision_shape.disabled = true
	lights_switch(false)

func on_enter():
	playback.travel(character.idle_animation)
	
func _on_awakening_zone_body_entered(_body: Node2D) -> void:
	if(get_parent().current_state == self):
		SignalBus.emit_camera_shook(2.5)
		await character.berserk_tween(1.0)
		lights_switch(true)
		attack_zone_collision_shape.disabled = false
		playback.travel(character.walk_animation)
		next_state = character.chase_state

func lights_switch(val : bool):
	for light in lights.get_children():
		if light is PointLight2D:
			light.enabled = val
