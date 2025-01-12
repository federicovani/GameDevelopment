class_name idle extends State

@export var sprite: Sprite2D
@export var knight_facing_collision_shape : FacingCollisionShapeKnight
@export var sword_facing_collision_shape : FacingCollisionShapeKnight

#Prevent entering the falling state when the game is starting
@onready var buffer_timer: Timer = $BufferTimer
	
func on_enter():
	playback.travel(character.idle_animation)

func state_process(_delta):
	if(!character.is_on_floor() && buffer_timer.is_stopped()):
		next_state = character.falling_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("crouch")):
		crouch()
	if(event.is_action_pressed("dash")):
		dash()
	if(event.is_action_pressed("attack")):
		attack()

func jump():
	next_state = character.jumping_state

func crouch():
	playback.travel(character.crouch_transition_animation)
	next_state = character.crouch_state

func dash():
	next_state = character.dash_state

func attack():
	next_state = character.attack_state

func _physics_process(delta):
	if(!get_parent().current_state == character.crouch_state):
		if get_parent().check_if_can_move():
			character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
			
			if character.direction && get_parent().check_if_can_move():
				character.velocity.x = character.direction.x * character.speed * delta
			else:
				character.velocity.x = move_toward(character.velocity.x, 0, character.speed)
				
			character.move_and_slide()
			update_facing_direction()

#Change sprite orientation
func update_facing_direction():
	if character.direction.x > 0:
		sprite.flip_h = false
	elif character.direction.x < 0:
		sprite.flip_h = true
	
	on_player_facing_direction_changed(!sprite.flip_h)

#Change collision shape orientation 
func on_player_facing_direction_changed(facing_right : bool):
	knight_facing_collision_shape.shape.set_size(knight_facing_collision_shape.standard_size)
	sword_facing_collision_shape.shape.set_size(sword_facing_collision_shape.standard_size)
	if(facing_right):
		knight_facing_collision_shape.position = knight_facing_collision_shape.facing_right_position
		sword_facing_collision_shape.position = sword_facing_collision_shape.facing_right_position
	else:
		knight_facing_collision_shape.position = knight_facing_collision_shape.facing_left_position
		sword_facing_collision_shape.position = sword_facing_collision_shape.facing_left_position
