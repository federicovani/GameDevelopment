extends Area2D

var picked : bool = false

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	picked = false

func _on_body_entered(_body: Node2D) -> void:
	if !picked:
		picked = true
		visible = false
		SignalBus.emit_on_coin_collected(10)
		SignalBus.emit_diamond_collected()
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
