extends RigidBody2D

# Variabili configurabili
@export var fall_delay: float = 1.0  # Ritardo prima della caduta (in secondi)

# Variabili interne
var has_fallen: bool = false  # Stato della piattaforma

# Nodi nella scena
@onready var fall_timer: Timer = $FallTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Configura la piattaforma inizialmente in modalità statica
	self.gravity_scale = 0  # Disabilita gravità inizialmente
	self.linear_velocity = Vector2.ZERO  # Nessun movimento iniziale

# Quando il corpo entra in contatto con la piattaforma
func _on_body_entered(body: Node) -> void:
	if body.name == "Knight" and not has_fallen:
		fall_timer.start(fall_delay)

# Quando il timer scade, fai cadere la piattaforma
func _on_fall_timer_timeout() -> void:
	has_fallen = true
	self.gravity_scale = 1  # Abilita la gravità per la piattaforma
