extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $ResetTimer

var velocity = Vector2()

func _physics_process(delta: float) -> void:
	velocity.y += Globals.gravity * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.


func _on_reset_timer_timeout() -> void:
	pass # Replace with function body.
