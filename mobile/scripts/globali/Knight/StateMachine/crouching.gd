class_name crouching extends State

@export var sprite: Sprite2D
@export var crouch_area : Area2D
@export var knight_facing_collision_shape : FacingCollisionShapeKnight
@export var sword_facing_collision_shape : FacingCollisionShapeKnight
@export var crouch_area_facing_collision_shape : FacingCollisionShape

func on_enter():
	playback.travel(character.crouch_animation)

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = character.falling_state
	if(!character.is_crouching && can_standup()):
		walk()
	if get_parent().check_if_can_move():
			character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
			
			if character.direction && get_parent().check_if_can_move():
				character.velocity.x = character.direction.x * character.crouching_speed * delta
			else:
				character.velocity.x = move_toward(character.velocity.x, 0, character.crouching_speed)
				
			character.move_and_slide()
			update_facing_direction()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("crouch")):
		character.is_crouching = true
	if(event.is_action_released("crouch")):
		character.is_crouching = false

func state_input(event: InputEvent):
	if(event.is_action_released("crouch") && can_standup()):
		walk()
	if(event.is_action_pressed("attack")):
		attack()

func walk():
	next_state = character.idle_state

func attack():
	next_state = character.crouch_attack_state

func can_standup() -> bool:
	return !crouch_area.has_overlapping_bodies()

#Change sprite orientation
func update_facing_direction():
	if character.direction.x > 0:
		sprite.flip_h = false
	elif character.direction.x < 0:
		sprite.flip_h = true
	
	on_player_facing_direction_changed(!sprite.flip_h)

#Change collision shape orientation 
func on_player_facing_direction_changed(facing_right : bool):
	knight_facing_collision_shape.shape.set_size(knight_facing_collision_shape.crouch_size)
	sword_facing_collision_shape.shape.set_size(sword_facing_collision_shape.crouch_size)
	if(facing_right):
		knight_facing_collision_shape.position = knight_facing_collision_shape.crouch_facing_right_position
		sword_facing_collision_shape.position = sword_facing_collision_shape.crouch_facing_right_position
		crouch_area_facing_collision_shape.position = crouch_area_facing_collision_shape.facing_right_position
	else:
		knight_facing_collision_shape.position = knight_facing_collision_shape.crouch_facing_left_position
		sword_facing_collision_shape.position = sword_facing_collision_shape.crouch_facing_left_position
		crouch_area_facing_collision_shape.position = crouch_area_facing_collision_shape.facing_left_position
