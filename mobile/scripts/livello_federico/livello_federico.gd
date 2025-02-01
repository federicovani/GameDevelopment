extends Node2D

@onready var rising_lava_animation_player: AnimationPlayer = $Layers/rising_lava/RisingLavaAnimationPlayer

func _ready() -> void:
	Global.current_level = "livello_federico"


func _on_lava_rising_trigger_body_entered(body: Node2D) -> void:
	if(body == Global.playerBody):
		SignalBus.emit_camera_shook(3)
		rising_lava_animation_player.play("rise")
