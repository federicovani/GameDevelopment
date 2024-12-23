extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@export var hit_state : State
@export var starting_move_direction : Vector2 = Vector2.RIGHT
@export var direction : Vector2
@export var movement_speed : float = 1250.0

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

@export var facing_collision_shape : FacingCollisionShapeSkeleton
@export var facing_ray_cast_left : FacingRayCastLeft
@export var facing_ray_cast_right : FacingRayCastRight

signal facing_direction_changed(facing_right : bool)

func _ready() -> void:
	animation_tree.active = true
	direction = starting_move_direction
	self.connect("facing_direction_changed", _on_skeleton_facing_direction_changed)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction && state_machine.check_if_can_move():
		if ray_cast_right.is_colliding():
			direction = Vector2.LEFT
			sprite.flip_h = true
			emit_signal("facing_direction_changed", !sprite.flip_h)
		if ray_cast_left.is_colliding():
			direction = Vector2.RIGHT
			sprite.flip_h = false
			emit_signal("facing_direction_changed", !sprite.flip_h)
		velocity.x = direction.x * movement_speed * delta
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()

func _on_skeleton_facing_direction_changed(facing_right : bool):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_right_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_left_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_left_position
