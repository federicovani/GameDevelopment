extends Node2D

@onready var rising_lava_animation_player: AnimationPlayer = $Layers/rising_lava/RisingLavaAnimationPlayer
@onready var camera: Camera2D = $knight/Camera2D

var default_camera_limit_top : int
var default_camera_limit_bottom : int

func _ready() -> void:
	Global.current_level = "livello_federico"


func _on_lava_rising_trigger_body_entered(body: Node2D) -> void:
	if(body == Global.playerBody):
		SignalBus.emit_camera_shook(3)
		rising_lava_animation_player.play("rise")

func save_camera_limits():
	default_camera_limit_top = camera.get_limit(SIDE_TOP)
	default_camera_limit_bottom = camera.get_limit(SIDE_BOTTOM)

func reset_camera_limits():
	camera.set_limit(SIDE_TOP, default_camera_limit_top)
	camera.set_limit(SIDE_BOTTOM, default_camera_limit_bottom)


func _on_vanishing_platforms_area_body_entered(body: Node2D) -> void:
	if(body == Global.playerBody):
		save_camera_limits()
		
		camera.set_limit(SIDE_TOP, -60)
		camera.set_limit(SIDE_BOTTOM, 342)

func _on_vanishing_platforms_area_body_exited(body: Node2D) -> void:
	if(body == Global.playerBody):
		reset_camera_limits()
	
