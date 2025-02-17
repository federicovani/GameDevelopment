extends RigidBody2D

@onready var area: Area2D = $Area2D

func _physics_process(_delta: float) -> void:
	if(area.has_overlapping_bodies()):
		position.y += 0.3
