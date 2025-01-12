class_name falling extends State

@onready var grab_hand_raycast: RayCast2D = $"../../GrabHandRaycast"
@onready var grab_check_raycast: RayCast2D = $"../../GrabCheckRaycast"
@onready var wall_check: ShapeCast2D = $"../../WallCheck"
@onready var floor_check: RayCast2D = $"../../FloorCheck"

func on_enter():
	playback.travel(character.jump_between_animation)

func state_process(_delta):
	check_ledge_grab()
	if(floor_check.is_colliding()):
		if character.is_crouching:
			playback.travel(character.crouch_transition_animation)
			next_state = character.crouch_state
		else:
			next_state = character.idle_state

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !character.is_on_floor() && get_parent().current_state != character.wall_hang_state:
		character.velocity.y += character.gravity * delta

func check_ledge_grab():
	if wall_check.is_colliding() && !floor_check.is_colliding() && character.velocity.y == 0:
		next_state = character.wall_hang_state
