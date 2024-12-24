extends State

class_name HitState

@onready var timer: Timer = $Timer

@export var knockback_speed : float = 20.0

@export var damageable : damageable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_taken : int, knockback_direction : Vector2):
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		playback.travel(character.hit_animation)
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", character.death_state)
		playback.travel(character.death_animation)

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	next_state = character.walk_state
