extends StaticBody2D

@export var delay_before_fall: float = 1.0  # Tempo in secondi prima che la piattaforma cada
@export var fall_speed: float = 200.0       # Velocità di caduta della piattaforma
@export var reset_time: float = 5.0         # Tempo dopo il quale la piattaforma si resetta

var is_falling: bool = false
var original_position: Vector2

func _ready():
	original_position = position
	# Connetti i segnali dell'Area2D
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("entrato")
	fall_after_delay()

func _on_body_exited(body):
	print("uscito")
	if is_falling:
		reset_platform_after_delay()

func fall_after_delay() -> void:
	is_falling = true
	await get_tree().create_timer(delay_before_fall).timeout
	set_process(true)  # Attiva il calcolo fisico per far cadere la piattaforma

func _physics_process(delta):
	if is_falling:
		position.y += fall_speed * delta

func reset_platform_after_delay() -> void:
	await get_tree().create_timer(reset_time).timeout
	_reset_platform()

func _reset_platform():
	is_falling = false
	position = original_position
	set_process(false)
