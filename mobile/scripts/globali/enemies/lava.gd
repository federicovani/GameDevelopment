extends Area2D

@onready var buffer_timer: Timer = $BufferTimer
@onready var kill_timer: Timer = $KillTimer

var rng = RandomNumberGenerator.new()

var to_damage : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if has_overlapping_bodies() && buffer_timer.is_stopped() && !kill_timer.is_stopped():
		for child in to_damage.get_children():
			if child is damageable:
					child.hit(get_damage(), Vector2.ZERO)
					buffer_timer.start()


func get_damage() -> int:
	return rng.randi_range(1, 10)

func _on_body_entered(body: Node2D) -> void:
	SignalBus.emit_fallen_in_lava()
	to_damage = body
	kill_timer.start()


func _on_kill_timer_timeout() -> void:
	if has_overlapping_bodies():
		SignalBus.emit_forced_death()
