class_name walk extends State

@export var ray_cast_right: RayCast2D
@export var ray_cast_left: RayCast2D

@export var facing_collision_shape : FacingCollisionShapeSkeleton
@export var facing_ray_cast_left : FacingRayCastLeft
@export var facing_ray_cast_right : FacingRayCastRight

@export var direction : Vector2
@export var starting_move_direction : Vector2 = Vector2.RIGHT

signal facing_direction_changed(facing_right : bool)

func _ready() -> void:
	direction = starting_move_direction
	self.connect("facing_direction_changed", _on_skeleton_facing_direction_changed)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	
	if direction && get_parent().check_if_can_move():
		#Change direction if the enemy collide with a wall
		if ray_cast_right.is_colliding():
			direction = Vector2.LEFT
			character.sprite.flip_h = true
			emit_signal("facing_direction_changed", !character.sprite.flip_h)
		if ray_cast_left.is_colliding():
			direction = Vector2.RIGHT
			character.sprite.flip_h = false
			emit_signal("facing_direction_changed", !character.sprite.flip_h)
		character.velocity.x = direction.x * character.movement_speed * delta
	elif get_parent().current_state != character.hit_state:
		character.velocity.x = move_toward(character.velocity.x, 0, character.movement_speed)

	character.move_and_slide()

func _on_skeleton_facing_direction_changed(facing_right : bool):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_right_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_left_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_left_position
