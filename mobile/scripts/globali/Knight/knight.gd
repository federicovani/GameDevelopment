class_name Knight extends CharacterBody2D

@export var speed : float = 130.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	
func _process(delta: float) -> void:
	update_animation_parameters()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)
