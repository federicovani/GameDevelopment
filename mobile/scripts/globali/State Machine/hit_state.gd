extends State

class_name HitState

@onready var timer: Timer = $Timer

@export var damageable : damageable
@export var death_state : State
@export var return_state : State
@export var death_animation : String = "death"
@export var hit_animation : String = "hit"

@export var knockback_speed : float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_taken : int, knockback_direction : Vector2):
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		playback.travel(hit_animation)
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", death_state)
		playback.travel(death_animation)

func on_exit():
	character.velocity = Vector2.ZERO

func _on_timer_timeout() -> void:
	next_state = return_state
