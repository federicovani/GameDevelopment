extends StaticBody2D

@onready var fall_timer: Timer = $FallTimer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var trigger_area: Area2D = $TriggerArea

func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body == Global.playerBody:
		fall_timer.start()
		animation_player.active = true
		animation_player.play("shake")
		trigger_area.set_deferred("monitoring", false)
	

func _on_fall_timer_timeout() -> void:
	animation_player.play("fall")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
	collision_shape_2d.disabled = true
	respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	animation_player.play("RESET")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.4)
	collision_shape_2d.disabled = false
	trigger_area.set_deferred("monitoring", true)
