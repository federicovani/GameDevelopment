extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@onready var sleep_state : State = $CharacterStateMachine/Sleep
@onready var walk_state : State = $CharacterStateMachine/Flying
@onready var chase_state : State = $CharacterStateMachine/Chase
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var attack_state : State = $CharacterStateMachine/Attack
@onready var death_state : State = $CharacterStateMachine/Death

@export var sleep_animation : String = "sleep"
@export var walk_animation : String = "fly"
@export var death_animation : String = "death"
@export var hit_animation : String = "hit"
@export var attack_animation : String = "attack"

@export var ray_cast_right: RayCast2D
@export var ray_cast_left: RayCast2D
@export var ray_cast_up: RayCast2D
@export var ray_cast_down: RayCast2D

@export var facing_collision_shape_attack_zone : FacingCollisionShape

@export var direction : Vector2 = Vector2.RIGHT
@export var facing_right : bool
@export var movement_speed : float = 50.0

@export var health : float = 20
@export var damage : float = 10

func _ready() -> void:
	animation_tree.active = true

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
		facing_collision_shape_attack_zone.position = facing_collision_shape_attack_zone.facing_right_position
	else:
		facing_collision_shape_attack_zone.position = facing_collision_shape_attack_zone.facing_left_position
