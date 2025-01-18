class_name falling extends State

@onready var dust = preload("res://scenes/globali/knight/dust.tscn")

@export var ledge_grab : CollisionShape2D 
@export var wall_check : ShapeCast2D 
@export var floor_check : ShapeCast2D 
@export var raycast_wall_check : RayCast2D
@export var marker : Marker2D

func on_enter():
	playback.travel(character.jump_between_animation)
	ledge_grab.disabled = false

func state_process(_delta):
	check_ledge_grab()
	if(floor_check.is_colliding()):
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

func check_ledge_grab():
	if raycast_wall_check.is_colliding():
		ledge_grab.disabled = true
	else:
		ledge_grab.disabled = false
	if wall_check.is_colliding() && !floor_check.is_colliding() && !raycast_wall_check.is_colliding() && character.velocity.y == 0:
		next_state = character.wall_hang_state

func get_gravity():
	if(character.velocity.y) < 0:
		return character.gravity
	return character.falling_gravity

func on_exit():
	character.update_player_audio(character.land_sfx)
	ledge_grab.disabled = true
