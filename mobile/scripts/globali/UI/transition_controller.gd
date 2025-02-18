class_name SceneTransitionController extends Control

@onready var background: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func fade_in(seconds : float):
	animation_player.play("fade_in", -1, 1 / seconds)

func fade_out(seconds : float):
	animation_player.play("fade_out", -1, 1 / seconds)
