extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "knight":
		timer.start()
		animation_player.play("shake")


func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4)
	collision_shape_2d.disabled = true
	respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	animation_player.play("RESET")
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.4)
	collision_shape_2d.disabled = false
