extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal key_collected  # Segnale per notificare che la chiave è stata raccolta

var picked : bool = false

func _ready() -> void:
	add_to_group("Keys")
	picked = false


func _on_body_entered(body: Node2D) -> void:
	if !picked && body == Global.playerBody:
		picked = true
		visible = false
		key_collected.emit()  # Emette il segnale
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
