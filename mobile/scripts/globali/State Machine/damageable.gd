class_name damageable extends Node

@warning_ignore("unused_signal")
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
