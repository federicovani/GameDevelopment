class_name Knight extends CharacterBody2D

@export var speed : float = 130.0
@export var health : float = 100

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

@onready var idle_state: State = $CharacterStateMachine/Idle
@onready var jumping_state: State = $CharacterStateMachine/Jumping
@onready var falling_state : State = $CharacterStateMachine/Falling
@onready var attack_state : State = $CharacterStateMachine/Attacking
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var death_state : State = $CharacterStateMachine/Death

@export var idle_animation : String = "move"
@export var attack1_animation : String = "attack1"
@export var attack2_animation : String = "attack2"
@export var jump_start_animation : String = "jump_start"
@export var jump_between_animation : String = "jump_in_between"
@export var turn_around_left_animation : String = "turn_around_to_left"
@export var hit_animation : String = "hit"
@export var death_animation : String = "death"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
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

func cannot_move():
	state_machine.current_state.can_move = false
