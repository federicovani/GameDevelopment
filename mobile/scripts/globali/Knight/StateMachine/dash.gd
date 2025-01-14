class_name rolling extends State

@export var dash_particles : GPUParticles2D
@onready var duration_timer: Timer = $DurationTimer

func on_enter():
	dash_particles.emitting = true
	duration_timer.start()

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = character.falling_state
	if character.facing_right:
		character.direction.x = 1
	else:
		character.direction.x = -1
	character.velocity.x = character.direction.x * character.dash_speed * delta
	
	character.idle_state.update_facing_direction()
	update_particles_facing_direction()
	character.move_and_slide()


func update_particles_facing_direction():
	if character.direction.x > 0:
		dash_particles.scale.x = 1
	elif character.direction.x < 0:
		dash_particles.scale.x = -1

func _on_duration_timer_timeout() -> void:
	next_state = character.idle_state

func on_exit():
	dash_particles.emitting = false
