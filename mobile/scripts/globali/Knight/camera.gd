extends Camera2D

var maxZoom : float = 5
var minZoom : float = 2

@export_range(0, 1, 0.05, "or_greater") var shake_power : float = 0.5
@export var shake_max_offset : float = 5.0 #Maximum shake in pixels
@export var shake_decay : float = 2.0
var shake_trauma : float = 0

func _ready() -> void:
	SettingsSignalBus.on_camera_zoom_edited.connect(_on_camera_zoom_edited)
	SignalBus.camera_shook.connect(_add_camera_shake)

func _physics_process(delta: float) -> void:
	if shake_trauma > 0:
		shake_trauma = max(shake_trauma - shake_decay * delta, 0)
		shake()
	
func _add_camera_shake(value : float):
	shake_trauma = value

func shake():
	var amount : float = pow(shake_trauma * shake_power, 2)
	offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_max_offset * amount

func _on_camera_zoom_edited(value : float):
	zoom.x = value
	zoom.y = value
