class_name Knight extends CharacterBody2D

@export var speed : float = 7000.0
@export var crouching_speed : float = 2000.0
@export var jump_velocity: float = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") #Get the gravity from the project settings to be synced with RigidBody nodes.

@export var health : float = 100

@export var is_crouching : bool = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

@onready var idle_state: State = $CharacterStateMachine/Idle
@onready var crouch_state: State = $CharacterStateMachine/Crouching
@onready var dash_state: State = $CharacterStateMachine/Dash
@onready var jumping_state: State = $CharacterStateMachine/Jumping
@onready var falling_state : State = $CharacterStateMachine/Falling
@onready var wall_hang_state : State = $CharacterStateMachine/Wall_Hang
@onready var attack_state : State = $CharacterStateMachine/Attacking
@onready var crouch_attack_state: Node = $CharacterStateMachine/Crouch_Attack
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var death_state : State = $CharacterStateMachine/Death

@export var idle_animation : String = "move"
@export var crouch_transition_animation : String = "crouch_transition"
@export var crouch_animation : String = "crouch_move"
@export var jump_start_animation : String = "jump_start"
@export var jump_between_animation : String = "jump_in_between"
@export var wall_hang_animation : String = "wall_hang"
@export var wall_climb_animation : String = "wall_climb"
@export var attack1_animation : String = "attack1"
@export var attack2_animation : String = "attack2"
@export var crouch_attack_animation : String = "crouch_attack"
@export var hit_animation : String = "hit"
@export var death_animation : String = "death"

@export var direction : Vector2 = Vector2.ZERO

@warning_ignore("unused_signal")
signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	Global.playerBody = self
	
func _process(_delta: float) -> void:
	update_animation_parameters()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)
	animation_tree.set("parameters/crouch_move/blend_position", direction.x)

func cannot_move():
	state_machine.current_state.can_move = false
