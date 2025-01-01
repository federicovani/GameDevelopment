class_name damageable extends Node

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func _ready() -> void:
	health = get_parent().health

func hit(damage : int, knockback_direction : Vector2):
	health -= damage
	emit_signal("on_hit", get_parent(), damage, knockback_direction)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == get_parent().death_animation):
		#character is finished dying, remove from the game
		get_parent().queue_free()
