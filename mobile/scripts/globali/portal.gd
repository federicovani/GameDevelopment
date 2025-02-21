extends Area2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var timer: Timer = $Timer
@onready var light: PointLight2D = $PointLight2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var playback : AnimationNodeStateMachinePlayback 

@export var emerge_animation : String = "emerge"
@export var idle_animation : String = "idle"
@export var vanish_animation : String = "vanish"

func _ready() -> void:
	animation_tree.active = true
	playback = animation_tree["parameters/playback"]
	playback.travel(emerge_animation)

func _on_body_entered(body: Node2D) -> void:
	if(body == Global.playerBody):
		audio_stream_player.play()
		playback.travel(vanish_animation)
		body.visible = false
		body.cannot_move()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == emerge_animation):
		light.enabled = true
		self.visible = true
	if(anim_name == vanish_animation):
		light.enabled = false
		self.visible = false
		timer.start()

func _on_timer_timeout() -> void:
	SignalBus.emit_signal("portal_crossed")
