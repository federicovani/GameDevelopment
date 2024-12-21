class_name damageable extends Node

@export var health : float = 50

func hit(damage : int):
	health -= damage
	
	if(health <= 0):
		get_parent().queue_free()
