class_name bat_sleep extends State

@export var ray_cast_sleep : RayCast2D

var is_on_ceiling : bool = false

func on_enter():
	is_on_ceiling = false

func state_process(delta):
	if(!character.is_on_ceiling()):
		character.velocity = - character.get_gravity() * delta
	elif(character.is_on_ceiling() && !is_on_ceiling):
		#When the bat is on the ceiling state_process starts doing nothing
		is_on_ceiling = true
		character.velocity = Vector2.ZERO
		playback.travel(character.sleep_animation)
	if(ray_cast_sleep.is_colliding()):
		next_state = character.chase_state
	character.move_and_slide()
