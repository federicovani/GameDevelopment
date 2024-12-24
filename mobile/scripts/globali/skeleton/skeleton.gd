extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@onready var walk_state : State = $CharacterStateMachine/Walk
@onready var hit_state : State = $CharacterStateMachine/Hit
@onready var death_state : State = $CharacterStateMachine/Death

@export var death_animation : String = "death"
@export var hit_animation : String = "hit"

@export var movement_speed : float = 1250.0

func _ready() -> void:
	animation_tree.active = true
