extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var picked : bool = false

func _ready() -> void:
	picked = false

func _on_body_entered(_body: Node2D) -> void:
	if !picked:
		picked = true
		visible = false
		SignalBus.emit_on_coin_collected(1)
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
