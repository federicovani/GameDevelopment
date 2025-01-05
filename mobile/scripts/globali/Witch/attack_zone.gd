extends Area2D

@onready var timer: Timer = $CollisionShape2D/BufferTimer

@export var player : Node2D
@export var state_machine: CharacterStateMachine
@export var exited : bool = false

@export var damage : float = 20

func _on_body_entered(body: Node2D) -> void:
	if(state_machine.current_state!=get_parent().death_state):
		player = body
		hit()

func _on_body_exited(_body: Node2D) -> void:
	exited = true

func hit():
	exited = false
	if(state_machine.current_state!=get_parent().death_state):
		for child in player.get_children():
			if is_instance_valid(child) && child is damageable:
				#Get direction from the zone to the body
				state_machine.switch_states(get_parent().attack_state)
				timer.start()
				await timer.timeout
				if !exited:
					var direction_to_damageable = (player.global_position - get_parent().global_position)
					var direction_sign = sign(direction_to_damageable.x)
					if(direction_sign > 0):
						child.hit(damage, Vector2.RIGHT)
					elif(direction_sign < 0):
						child.hit(damage, Vector2.LEFT)
					else:
						child.hit(damage, Vector2.ZERO)
	
