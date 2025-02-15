extends RigidBody2D

@onready var area: Area2D = $Area2D
@onready var marker: Marker2D = $Marker

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(area.has_overlapping_bodies()):
		var distance = Global.playerBody.global_position.x - marker.global_position.x
		if((distance < 20 || distance > -20) && rotation != 0):
			rotation = lerp(rotation, 0.0, delta)
		if(distance < -20 || distance > 20):
			var angular : float = distance/2
			angular_velocity = angular * delta
	else:
		if(rotation != 0):
			rotation = lerp(rotation, 0.0, delta)
