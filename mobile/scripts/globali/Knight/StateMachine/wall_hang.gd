class_name wall_hang extends State

@export var wall_check: ShapeCast2D

@export var wall_climb_speed : float = 4000.0
@export var wall_climb_jump_speed : float = -260.0

@export var can_climb : bool = false
@export var dropped : bool = false

func on_enter():
	check_orientation()
	playback.travel(character.wall_hang_animation)
	can_climb = false
	dropped = false

func state_process(delta: float) -> void:
	if can_climb:
		character.velocity.y += character.gravity * delta
		character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
		
		if character.direction:
			character.velocity.x = character.direction.x * wall_climb_speed * delta
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, wall_climb_speed)
			
		character.move_and_slide()
	if dropped:
		character.velocity.y += character.gravity * delta

func check_orientation():
	var collider = wall_check.get_collision_normal(0)
	character.direction.x = -collider.x
	character.idle_state.update_facing_direction()
		
func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("crouch")):
		dropped = true
		await get_tree().create_timer(0.10).timeout
		next_state = character.idle_state

func jump():
	can_climb = true
	playback.travel(character.wall_climb_animation)
	character.velocity.y = wall_climb_jump_speed

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == character.wall_climb_animation):
		next_state = character.falling_state
