extends AnimatableBody2D

func _ready() -> void:
	visible = false  # Nasconde la piattaforma all'inizio
	var key_node = get_node("res://scenes/livello_sara/key.tscn") 
	if key_node:
		key_node.key_collected.connect(_on_key_collected)
		print("Segnale collegato con successo")  # Debug
	else:
		print("Errore: nodo chiave non trovato")  # Debug

func _on_key_collected() -> void:
	print("Segnale ricevuto, piattaforma visibile")  # Debug
	visible = true  # Mostra la piattaforma
