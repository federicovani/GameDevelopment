extends State

class_name HitState

@onready var timer: Timer = $Timer
@onready var hit_flash_animation_player: AnimationPlayer = $"../../HitFlashAnimationPlayer"

@export var knockback_speed : float = 15.0

@export var damageable : damageable

func _ready() -> void:
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	if(character == Global.playerBody):
		character.update_player_audio(character.hit_sfx)
	timer.start()
	SignalBus.emit_camera_shook(1.5)

func on_damageable_hit(_node : Node, _damage_taken : int, knockback_direction : Vector2):
	if(hit_flash_animation_player != null):
		hit_flash_animation_player.play("hit_flash")
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		playback.travel(character.hit_animation)
		emit_signal("interrupt_state", self)
	else:
		if(character == Global.playerBody):
			#For the Player
			SignalBus.emit_on_health_decreased()
			SignalBus.emit_camera_shook(1.5)
			damageable.reset_health()
			if(PlayerStatsManager.current_hearth_amount > 0):
				playback.travel(character.hit_animation)
				emit_signal("interrupt_state", self)
		else:
			#For the enemies
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
