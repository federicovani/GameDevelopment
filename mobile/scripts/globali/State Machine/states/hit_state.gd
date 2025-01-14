extends State

class_name HitState

@onready var timer: Timer = $Timer

@export var knockback_speed : float = 20.0

@warning_ignore("shadowed_global_identifier")
@export var damageable : damageable

func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	timer.start()

func on_damageable_hit(_node : Node, _damage_taken : int, knockback_direction : Vector2):
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		playback.travel(character.hit_animation)
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", character.death_state)

func _on_timer_timeout() -> void:
	if(character == Global.playerBody):
	#For the Player
		if character.is_crouching || !character.crouch_state.can_standup():
			playback.travel(character.crouch_transition_animation)
			next_state = character.crouch_state
		else:
			next_state = character.idle_state
	#For the enemies
	else: 
		next_state = character.chase_state

func on_exit():
	character.velocity = Vector2.ZERO
