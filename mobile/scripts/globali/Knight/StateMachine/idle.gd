class_name idle extends State

@onready var buffer_timer: Timer = $BufferTimer

@export var sprite: Sprite2D
@export var facing_collision_shape : FacingCollisionShapeKnight

@export var jumping_state: State
@export var falling_state : State
@export var attack_state : State
@export var death_state : State

@export var idle_animation : String = "move"
@export var turn_around_left_animation : String = "turn_around_to_left"

@export var jump_velocity: float = -300.0

signal facing_direction_changed(facing_right : bool)

func on_enter():
	playback.travel(idle_animation)
	self.connect("facing_direction_changed", _on_player_facing_direction_changed)

func state_process(delta):
	if(!character.is_on_floor() && buffer_timer.is_stopped()):
		next_state = falling_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("attack")):
		attack()

func jump():
	character.velocity.y = jump_velocity
	next_state = jumping_state

func attack():
	next_state = attack_state

func _physics_process(delta):
	# Add the gravity.
	if not character.is_on_floor():
		character.velocity.y += character.gravity * delta

	character.direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
	
	if character.direction && get_parent().check_if_can_move():
		character.velocity.x = character.direction.x * character.speed
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, character.speed)
		
	character.move_and_slide()
	update_facing_direction()

func update_facing_direction():
	if character.direction.x > 0:
		sprite.flip_h = false
	elif character.direction.x < 0:
		#playback.travel(turn_around_left_animation)
		sprite.flip_h = true
		
	emit_signal("facing_direction_changed", !sprite.flip_h)

#Change sprite orientation 
func _on_player_facing_direction_changed(facing_right : bool):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
