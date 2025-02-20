extends Node2D

@onready var knight: Knight = $knight
@onready var checkpoint_campfire: Area2D = $checkpoint_campfire

func _ready() -> void:
	if(LevelStats.is_checkpoint_taken()):
		knight.global_position = checkpoint_campfire.global_position
