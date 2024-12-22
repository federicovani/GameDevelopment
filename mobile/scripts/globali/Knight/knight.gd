class_name Knight extends CharacterBody2D

@export var speed : float = 130.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@export var facing_collision_shape : FacingCollisionShapeKnight

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	self.connect("facing_direction_changed", _on_player_facing_direction_changed)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "jump", "ui_down")
	
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_player_facing_direction_changed(facing_right : bool):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position
