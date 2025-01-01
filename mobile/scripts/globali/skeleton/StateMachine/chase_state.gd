class_name chase extends State

@export var direction : Vector2

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player = SignalBus.playerBody
	if (get_parent().current_state == self):
		if not character.is_on_floor():
			character.velocity += character.get_gravity() * delta
		if get_parent().check_if_can_move():
			direction = character.position.direction_to(player.position) * character.movement_speed * delta
			character.velocity.x = direction.x
		character.move_and_slide()
