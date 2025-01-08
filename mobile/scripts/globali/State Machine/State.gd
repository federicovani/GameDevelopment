class_name State extends Node

@export var can_move: bool = true

var character : CharacterBody2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

@warning_ignore("unused_signal")
signal interrupt_state(new_state : State)

func state_process(_delta):
	pass

func state_input(_event: InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
