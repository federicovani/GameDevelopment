extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	visible = false  # Nasconde la piattaforma all'inizio
	collision_shape_2d.disabled = true # Elimina la collision shape all'inizio
	try_connect_key()

func try_connect_key():
	var keys = get_tree().get_nodes_in_group("Keys")
	
	if keys.size() > 0:
		keys[0].key_collected.connect(_on_key_collected)
	else:
		await get_tree().create_timer(1.0).timeout  # Aspetta 1 secondo e riprova
		try_connect_key()  # Riprova fino a che non trova la chiave

func _on_key_collected() -> void:
	visible = true  # Mostra la piattaforma
	set_deferred("collision_shape_2d.disabled", false) #Ripristina la collisione
	
	# Forza l'aggiornamento della fisica
	await get_tree().physics_frame
	collision_shape_2d.set_deferred("disabled", false)
