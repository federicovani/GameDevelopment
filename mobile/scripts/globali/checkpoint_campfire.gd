extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var light: PointLight2D = $PointLight2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	if LevelStats.is_checkpoint_taken():
		animation_player.play("fire")
		light.enabled = true
		audio_stream_player.play()
	else:
		animation_player.play("no_fire")
		light.enabled = false
		audio_stream_player.stop()

func _on_body_entered(body: Node2D) -> void:
	if(body == Global.playerBody && !LevelStats.is_checkpoint_taken()):
		SignalBus.emit_checkpoint_taken()
		animation_player.play("fire")
		light.enabled = true
		audio_stream_player.play()
