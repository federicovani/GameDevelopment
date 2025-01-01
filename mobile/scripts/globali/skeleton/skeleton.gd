extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@onready var walk_state : State = $CharacterStateMachine/Walk
@onready var chase_state : State = $CharacterStateMachine/Chase
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var death_state : State = $CharacterStateMachine/Death

@export var death_animation : String = "death"
@export var hit_animation : String = "hit"

@export var ray_cast_right: RayCast2D
@export var ray_cast_left: RayCast2D

@export var facing_collision_shape : FacingCollisionShapeSkeleton
@export var facing_ray_cast_left : FacingRayCastLeft
@export var facing_ray_cast_right : FacingRayCastRight

@export var movement_speed : float = 1250.0

signal facing_direction_changed(facing_right : bool)

func _ready() -> void:
	animation_tree.active = true
	self.connect("facing_direction_changed", _on_skeleton_facing_direction_changed)

#Handling CollisionShape and RayCast when character changes direction
func _on_skeleton_facing_direction_changed(facing_right : bool):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_right_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
		facing_ray_cast_left.position = facing_ray_cast_left.facing_left_position
		facing_ray_cast_right.position = facing_ray_cast_right.facing_left_position
