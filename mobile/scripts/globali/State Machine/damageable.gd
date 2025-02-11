class_name damageable extends Node

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : float :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func _ready() -> void:
	reset_health()

func hit(damage : int, knockback_direction : Vector2):
	if(get_parent().state_machine.current_state != get_parent().death_state):
		health -= damage
		emit_signal("on_hit", get_parent(), damage, knockback_direction)

func reset_health():
	health = get_parent().health
