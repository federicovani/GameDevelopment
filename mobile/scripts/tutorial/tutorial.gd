extends Node2D

@onready var quest_box_move: MarginContainer = $QuestBoxes/QuestBoxMove
@onready var quest_box_jump: MarginContainer = $QuestBoxes/QuestBoxJump
@onready var quest_box_hold_jump: MarginContainer = $QuestBoxes/QuestBoxHoldJump
@onready var quest_box_wall_hang: MarginContainer = $QuestBoxes/QuestBoxWallHang
@onready var quest_box_dash: MarginContainer = $QuestBoxes/QuestBoxDash
@onready var quest_box_crouch: MarginContainer = $QuestBoxes/QuestBoxCrouch
@onready var quest_box_checkpoint: MarginContainer = $QuestBoxes/QuestBoxCheckpoint
@onready var quest_box_attack: MarginContainer = $QuestBoxes/QuestBoxAttack

@onready var knight: Knight = $knight
@onready var checkpoint_campfire: Area2D = $checkpoint_campfire
@onready var move_label: Label = $QuestBoxes/QuestBoxMove/MarginContainer/Label
@onready var jump_label: Label = $QuestBoxes/QuestBoxJump/MarginContainer/Label
@onready var hold_jump_label: Label = $QuestBoxes/QuestBoxHoldJump/MarginContainer/Label
@onready var dash_label: Label = $QuestBoxes/QuestBoxDash/MarginContainer/Label
@onready var crouch_label: Label = $QuestBoxes/QuestBoxCrouch/MarginContainer/Label
@onready var attack_label: Label = $QuestBoxes/QuestBoxAttack/MarginContainer/Label

var box_to_fade : MarginContainer
var pressed : bool = false

func _ready() -> void:
	SignalBus.connect("update_tutorial_keybinds_labels", update_labels)
	box_to_fade = quest_box_move
	pressed = false
	update_labels()
	if(LevelStats.is_checkpoint_taken()):
		#Migliorabile
		knight.global_position = checkpoint_campfire.global_position

func _input(event: InputEvent) -> void:
	if(box_to_fade != null):
		match box_to_fade:
			quest_box_move:
				if(!pressed && event.is_action_pressed("move_right")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = quest_box_jump
					fade_in()
			quest_box_jump:
				if(!pressed && event.is_action_pressed("jump")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = quest_box_hold_jump
					fade_in()
			quest_box_hold_jump:
				if(!pressed && event.is_action_pressed("jump")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = quest_box_wall_hang
					fade_in()
			quest_box_wall_hang:
				if(!pressed && event.is_action_pressed("jump")):
					await get_tree().create_timer(0.5).timeout
					if(knight.state_machine.current_state == knight.wall_hang_state):
						pressed = true
						await fade_out()
						pressed = false
						box_to_fade = quest_box_dash
						fade_in()
			quest_box_dash:
				if(!pressed && event.is_action_pressed("dash")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = quest_box_crouch
					fade_in()
			quest_box_crouch:
				if(!pressed && event.is_action_pressed("crouch")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = quest_box_checkpoint
					fade_in()
			quest_box_checkpoint:
				if(!pressed && (event.is_action_pressed("move_right") || event.is_action_pressed("move_left"))):
					if(LevelStats.is_checkpoint_taken()):
						pressed = true
						await fade_out()
						pressed = false
						box_to_fade = quest_box_attack
						fade_in()
			quest_box_attack:
				if(!pressed && event.is_action_pressed("attack")):
					pressed = true
					await fade_out()
					pressed = false
					box_to_fade = null

func fade_in():
	fade_tween(1.0)

func fade_out():
	await get_tree().create_timer(1.0).timeout
	await fade_tween(0.0)

func set_box_opacity(val : float):
	box_to_fade.modulate.a = val

func fade_tween(set_to : float) -> bool:
	var tween = get_tree().create_tween()
	tween.tween_method(set_box_opacity, 1.0 - set_to, set_to, 1.0)
	await tween.finished
	return true

func update_labels() -> void:
	update_move_label()
	update_jump_labels()
	update_dash_label()
	update_crouch_label()
	update_attack_label()

func update_move_label():
	var move_left = get_keybind_string("move_left")
	var move_right = get_keybind_string("move_right")
	
	move_label.text = "Press %s and %s to\nmove around" % [move_left, move_right]

func update_jump_labels():
	var jump = get_keybind_string("jump")
	
	jump_label.text = "Press %s\nto jump" % [jump]
	hold_jump_label.text = "Hold %s to\njump higher" % [jump]

func update_dash_label():
	var dash = get_keybind_string("dash")
	
	dash_label.text = "Press %s\nto dash" % [dash]

func update_crouch_label():
	var crouch = get_keybind_string("crouch")
	
	crouch_label.text = "Hold %s\nto crouch" % [crouch]

func update_attack_label():
	var attack = get_keybind_string("attack")
	
	attack_label.text = "Press %s\nto attack" % [attack]

func get_keybind_string(action : String) -> String:
	var action_events = InputMap.action_get_events(action)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	return action_keycode
