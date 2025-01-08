extends Area2D

@export var character : CharacterBody2D
@export var player : Node2D
@export var to_damage : damageable
@export var state_machine: CharacterStateMachine

@export var damage : float

func _ready() -> void:
	damage = character.damage

func _on_body_entered(body: Node2D) -> void:
	if(state_machine.current_state!=character.death_state):
		player = body
		for child in player.get_children():
			if is_instance_valid(child) && child is damageable:
				to_damage = child
				state_machine.switch_states(character.attack_state)

#Handled by the AnimationPlayer, called when the animation actually hit the player
func hit():
	#If the player didn't left the attack zone during the first part of the animation then deal the damage
	if has_overlapping_bodies():
		#Get direction from the zone to the body
		var direction_to_damageable = (player.global_position - character.global_position)
		var direction_sign = sign(direction_to_damageable.x)
		if(direction_sign > 0):
			to_damage.hit(damage, Vector2.RIGHT)
		elif(direction_sign < 0):
			to_damage.hit(damage, Vector2.LEFT)
		else:
			to_damage.hit(damage, Vector2.ZERO)
	
