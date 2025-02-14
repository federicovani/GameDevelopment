extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var gray_sprite: Sprite2D = $Sprite2D
@onready var light: PointLight2D = $PointLight2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var picked : bool = false
@export_range(0, 2, 1) var diamond_number : int

func _ready() -> void:
	if(LevelStats.is_diamond_taken(diamond_number)):
		picked = true
		animated_sprite.visible = false
		gray_sprite.visible = true
		light.enabled = false
	else:
		picked = false
		animated_sprite.visible = true
		gray_sprite.visible = false
		light.enabled = true

func _on_body_entered(_body: Node2D) -> void:
	if !picked:
		picked = true
		visible = false
		SignalBus.emit_on_coin_collected(10)
		SignalBus.emit_diamond_collected(diamond_number)
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
