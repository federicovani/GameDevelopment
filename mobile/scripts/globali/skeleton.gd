class_name damageable extends Node

@export var health : float = 50 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

func hit(damage : int):
	health -= damage
	#print_debug("Health: " + str(health))
	if(health <= 0):
		get_parent().queue_free()
