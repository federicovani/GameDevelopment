class_name PushableObject extends RigidBody2D

@export var push_force: float = 140.0
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_playing: bool = false
var is_being_pushed: bool = false

func _physics_process(_delta: float) -> void:
	# Controlla se l'oggetto è in movimento
	if linear_velocity.x != 0 and not is_being_pushed:
		is_being_pushed = true
	elif linear_velocity.x == 0 and is_being_pushed:
		is_being_pushed = false
	audio_manager()

func audio_manager():
	if is_being_pushed:
		if !is_playing:
			audio_stream_player_2d.play()
			is_playing = true
	else:
		is_playing = false
		audio_stream_player_2d.stop()
		# fade_out_audio()
