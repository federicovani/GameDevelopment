extends Area2D

@export var damage : int = 20

func _ready():
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is damageable:
			child.hit(damage)
			#print_debug(body.name + " took " + str(damage) + " damage")
	
