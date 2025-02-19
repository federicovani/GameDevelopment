class_name idle extends State

@export var sprite: FacingSpriteOffset
@export var knight_facing_collision_shape : FacingCollisionShapeKnight
@export var sword_facing_collision_shape : FacingCollisionShapeKnight
@export var raycast_wall_check : RayCast2D
@export var raycast_ledge_grab : RayCast2D

@onready var walking_particles: GPUParticles2D = $"../../WalkingParticles"

@onready var attack_buffer_timer: Timer = $"../Attacking/BufferTimer"

#Prevent entering the falling state when the game is starting
@onready var buffer_timer: Timer = $BufferTimer
@export var dash_timer : Timer

var acceleration : float = 15
var deceleration : float = 25

#Timer for the coyote jump
var coyote_time : float = 0.1

	
func on_enter():
	playback.travel(character.idle_animation)
	character.update_player_audio(character.reset_sfx)
	set_collision_shapes()

func state_process(_delta):
	if(!character.is_on_floor() && buffer_timer.is_stopped()):
		get_tree().create_timer(coyote_time).timeout.connect(_on_coyote_timeout)
			
	if character.direction:
		walking_particles.emitting = true
	else:
		walking_particles.emitting = false

func _physics_process(delta):
	if(get_parent().check_if_can_move() && !get_parent().current_state == character.crouch_state && !get_parent().current_state == character.dash_state):
		character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
		
		if character.direction:
			character.velocity.x = move_toward(character.velocity.x, character.direction.x * character.speed * delta, acceleration)
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, deceleration)

		update_facing_direction()

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("crouch")):
		crouch()
	if(event.is_action_pressed("dash")):
		dash()
	if(event.is_action_pressed("attack") && attack_buffer_timer.is_stopped()):
		attack()

func jump():
	next_state = character.jumping_state

func crouch():
	playback.travel(character.crouch_transition_animation)
	next_state = character.crouch_state

func dash():
	if dash_timer.is_stopped():
		next_state = character.dash_state
		dash_timer.start()

func attack():
	next_state = character.attack_state

func _on_coyote_timeout():
	if !character.is_on_floor():
		next_state = character.falling_state

func set_collision_shapes():
	knight_facing_collision_shape.shape.set_size(knight_facing_collision_shape.standard_size)
	sword_facing_collision_shape.shape.set_size(sword_facing_collision_shape.standard_size)
	knight_facing_collision_shape.position = knight_facing_collision_shape.facing_right_position
	knight_facing_collision_shape.position = knight_facing_collision_shape.facing_left_position
	
#Change sprite orientation
func update_facing_direction():
	if character.direction.x > 0:
		sprite.flip_h = false
	elif character.direction.x < 0:
		sprite.flip_h = true
	
	on_player_facing_direction_changed(!sprite.flip_h)

#Change collision shape orientation 
func on_player_facing_direction_changed(facing_right : bool):
	character.facing_right = facing_right
	if(facing_right):
		sprite.offset = sprite.facing_right_offset
		sword_facing_collision_shape.position = sword_facing_collision_shape.facing_right_position
		raycast_wall_check.scale.x = 1
		raycast_ledge_grab.scale.x = 1
	else:
		sprite.offset = sprite.facing_left_offset
		sword_facing_collision_shape.position = sword_facing_collision_shape.facing_left_position
		raycast_wall_check.scale.x = -1
		raycast_ledge_grab.scale.x = -1

func on_exit():
	walking_particles.emitting = false
