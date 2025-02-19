extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@onready var walk_state : State = $CharacterStateMachine/Walk
@onready var chase_state : State = $CharacterStateMachine/Chase
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var attack_state : State = $CharacterStateMachine/Attack
@onready var death_state : State = $CharacterStateMachine/Death

@export var walk_animation : String = "walk"
@export var death_animation : String = "death"
@export var hit_animation : String = "hit"
@export var attack1_animation : String = "attack1"
@export var attack2_animation : String = "attack2"

@export var ray_cast_right: RayCast2D
@export var ray_cast_left: RayCast2D
@export var ray_cast_down: RayCast2D

@export var facing_collision_shape_attack_zone_near : FacingCollisionShape
@export var facing_collision_shape_attack_zone_far : FacingCollisionShape
@export var facing_ray_cast_down : FacingRayCast

@export var attack_type : int = 0

@export var direction : Vector2 = Vector2.RIGHT
@export var facing_right : bool
@export var movement_speed : float = 750.0
@export var chase_speed : float = 1000.0

@export var health : float = 50
@export var damage : float = 25

func _ready() -> void:
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	handle_orientation()

#Handling Character's Sprite orientation
func handle_orientation():
	if(direction.x > 0):
		sprite.flip_h = false
	elif(direction.x < 0):
		sprite.flip_h = true
	on_facing_direction_changed(!sprite.flip_h)
	
#Handling CollisionShape and RayCast when character changes direction
@warning_ignore("shadowed_variable")
func on_facing_direction_changed(facing_right : bool):
	self.facing_right = facing_right
	if(facing_right):
		facing_collision_shape_attack_zone_near.position = facing_collision_shape_attack_zone_near.facing_right_position
		facing_collision_shape_attack_zone_far.position = facing_collision_shape_attack_zone_far.facing_right_position
		facing_ray_cast_down.position = facing_ray_cast_down.facing_right_position
	else:
		facing_collision_shape_attack_zone_near.position = facing_collision_shape_attack_zone_near.facing_left_position
		facing_collision_shape_attack_zone_far.position = facing_collision_shape_attack_zone_far.facing_left_position
		facing_ray_cast_down.position = facing_ray_cast_down.facing_left_position
