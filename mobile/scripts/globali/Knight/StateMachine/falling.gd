class_name falling extends State

@onready var dust = preload("res://scenes/globali/knight/dust.tscn")

@export var ledge_grab : CollisionShape2D 
@export var wall_check : ShapeCast2D 
@export var floor_check : ShapeCast2D 
@export var raycast_wall_check : RayCast2D
@export var raycast_ledge_grab : RayCast2D
@export var marker : Marker2D

var jump_buffer = false
var jump_buffer_timer : float = 0.1

func on_enter():
	playback.travel(character.jump_between_animation)
	jump_buffer = false

func state_process(_delta):
	check_ledge_grab()
	if(character.is_on_floor()):
		if jump_buffer:
			next_state = character.jumping_state
			jump_buffer = false
		else:
			if character.is_crouching:
				playback.travel(character.crouch_transition_animation)
				next_state = character.crouch_state
			else:
				next_state = character.idle_state
		#Add the dust effect when landing
		var instance = dust.instantiate()
		instance.position = marker.position
		character.add_child(instance)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !character.is_on_floor() && get_parent().current_state != character.wall_hang_state:
		character.velocity.y += get_gravity() * delta

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump_buffer = true
		get_tree().create_timer(jump_buffer_timer).timeout.connect(_on_buffer_jump_timeout)

func check_ledge_grab():
	if !raycast_wall_check.is_colliding() && raycast_ledge_grab.is_colliding():
		next_state = character.wall_hang_state

func get_gravity():
	if(character.velocity.y) < 0:
		return character.gravity
	return character.falling_gravity

func _on_buffer_jump_timeout():
	jump_buffer = false
