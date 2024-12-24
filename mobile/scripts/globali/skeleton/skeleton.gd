extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var sprite: Sprite2D = $Sprite2D

@export var hit_state : State
@export var movement_speed : float = 1250.0

func _ready() -> void:
	animation_tree.active = true
