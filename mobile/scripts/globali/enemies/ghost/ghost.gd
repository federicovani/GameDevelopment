extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@onready var idle_state : State = $CharacterStateMachine/Idle
@onready var chase_state : State = $CharacterStateMachine/Chase
@onready var attack_state : State = $CharacterStateMachine/Attack
@onready var death_state : State = null

@export var idle_animation : String = "idle"
@export var walk_animation : String = "walk"
@export var attack_animation : String = "attack"

@export var facing_collision_shape_attack_zone : FacingCollisionShape

@export var fade_duration: float = 1.0  # Durata della dissolvenza
var fade_timer: Timer
var fade_in_progress: bool = false
var fade_out_progress: bool = false

@export var direction : Vector2 = Vector2.RIGHT
@export var facing_right : bool = true
@export var movement_speed : float = 1250.0

@export var health : float = 100
@export var damage : float = 40

func _ready() -> void:
	animation_tree.active = true
	set_sprite_opacity(0.0)

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _process(_delta: float) -> void:
	handle_orientation()

func fade_in():
	fade_tween(0.6)

func fade_out():
	fade_tween(0.0)

func set_sprite_opacity(val : float):
	sprite.modulate.a = val

func fade_tween(set_to : float) -> bool:
	var tween = get_tree().create_tween()
	tween.tween_method(set_sprite_opacity, 1.0 - set_to, set_to, 1.0)
	await tween.finished
	return true

#Handling Character's Sprite orientation
func handle_orientation():
	if(direction.x > 0):
		sprite.flip_h = false
	elif(direction.x < 0):
		sprite.flip_h = true
	on_facing_direction_changed(!sprite.flip_h)
	
#Handling CollisionShape and RayCast when character changes direction
func on_facing_direction_changed(facing_right : bool):
	self.facing_right = facing_right
	if(facing_right):
		facing_collision_shape_attack_zone.position = facing_collision_shape_attack_zone.facing_right_position
	else:
		facing_collision_shape_attack_zone.position = facing_collision_shape_attack_zone.facing_left_position
