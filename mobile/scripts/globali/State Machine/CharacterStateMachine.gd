extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State
@export var animation_tree : AnimationTree

var states: Array[State]

#Chech if all the state nodes are in the array and add them if not
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			#Set the state up with what they need to function
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			#Connect to the interrupt signal
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning(("Child " + child.name + "is not a State for StateMachine"))

func _physics_process(delta : float) -> void:
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move

func switch_states(new_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	if(!new_state.can_move):
		character.velocity.x = 0
	current_state = new_state
	current_state.on_enter()
	
func _input(event : InputEvent):
	current_state.state_input(event)
	
func on_state_interrupt_state(new_state : State):
	if(current_state != get_parent().death_state):
		switch_states(new_state)
