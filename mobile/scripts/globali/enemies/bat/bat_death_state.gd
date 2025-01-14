class_name bat_death extends State

#Handle the death animation offset
@export var ray_cast_death : RayCast2D

var is_on_floor : bool = false

func on_enter():
	playback.travel(character.death_animation)

func state_process(delta):
	if(!ray_cast_death.is_colliding()):
		character.velocity = character.get_gravity() * delta
	elif(ray_cast_death.is_colliding() && !is_on_floor):
		#When the bat is on the floor state_process starts doing nothing
		is_on_floor = true
		character.velocity = Vector2.ZERO
		remove()
	character.move_and_slide()

func remove():
	await get_tree().create_timer(0.5).timeout
	character.queue_free()
