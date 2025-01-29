extends Area2D

@export var timer: Timer
@export var character : CharacterBody2D
@export var player : Node2D = Global.playerBody
@export var to_damage : damageable

var rng = RandomNumberGenerator.new()

@export var damage : int

func _ready() -> void:
	damage = character.damage

func _process(_delta: float) -> void:
	if has_overlapping_bodies() && timer.is_stopped():
		if(character.state_machine.current_state!=character.death_state && timer.is_stopped()):
			for child in player.get_children():
				if is_instance_valid(child) && child is damageable:
					to_damage = child
					character.attack_type = 1
					character.state_machine.switch_states(character.attack_state)
					timer.start()

func get_damage() -> int:
	return rng.randi_range(damage - 5, damage + 5)

func _on_body_entered(body: Node2D) -> void:
	if(character.state_machine.current_state!=character.death_state && timer.is_stopped()):
		player = body

#Handled by the AnimationPlayer, called when the animation actually hit the player
func hit():
	#If the player didn't left the attack zone during the first part of the animation then deal the damage
	if has_overlapping_bodies():
		#Get direction from the zone to the body
		var direction_to_damageable = (player.global_position - character.global_position)
		var direction_sign = sign(direction_to_damageable.x)
		if(direction_sign > 0):
			to_damage.hit(get_damage(), Vector2.RIGHT)
		elif(direction_sign < 0):
			to_damage.hit(get_damage(), Vector2.LEFT)
		else:
			to_damage.hit(get_damage(), Vector2.ZERO)
	
