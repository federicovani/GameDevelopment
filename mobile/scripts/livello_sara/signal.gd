extends Area2D

func _ready() -> void:
	visible = false
	try_connect_key()
	
func try_connect_key():
	var keys = get_tree().get_nodes_in_group("Keys")
	
	if keys.size() > 0:
		keys[0].key_collected.connect(_on_key_collected)
	else:
		await get_tree().create_timer(1.0).timeout  # Aspetta 1 secondo e riprova
		try_connect_key()  # Riprova fino a che non trova la chiave

func _on_key_collected() -> void:
	visible = true  # Mostra il cartello
