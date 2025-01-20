class_name rolling extends State

@export var dash_particles : GPUParticles2D

@export var dash_max_distance = 115
@export var dash_curve : Curve

var dash_start_position = 0

func on_enter():
	character.update_player_audio(character.dash_sfx)
	dash_particles.emitting = true
	dash_start_position = character.position.x

func state_process(delta):
	if character.facing_right:
		character.direction.x = 1
	else:
		character.direction.x = -1
	
	var current_distance = abs(character.position.x - dash_start_position)
	if(current_distance >= dash_max_distance || character.is_on_wall()):
		next_state = character.idle_state
	else:
		character.velocity.x = character.direction.x * character.dash_speed * dash_curve.sample(current_distance / dash_max_distance) * delta
	
	character.idle_state.update_facing_direction()
	update_particles_facing_direction()
	character.move_and_slide()


func update_particles_facing_direction():
	if character.direction.x > 0:
		dash_particles.scale.x = 1
	elif character.direction.x < 0:
		dash_particles.scale.x = -1

func on_exit():
	dash_particles.emitting = false
	
