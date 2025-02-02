extends Area2D

@export var teleport_position: Vector2 = Vector2(6600, 110)
@export var fade_duration: float = 1.0  # Durata della dissolvenza

var fade_rect: ColorRect
var fade_timer: Timer
var fade_in_progress: bool = false
var fade_out_progress: bool = false

func _ready():
	# Trova il ColorRect (assicurati che sia un figlio del CanvasLayer)
	fade_rect = $CanvasLayer/ColorRect
	fade_rect.modulate.a = 0  # Imposta l'opacità iniziale a 0 (trasparente)
	fade_rect.visible = false  # Disabilita la visibilità del ColorRect inizialmente

	# Crea il timer per la dissolvenza
	fade_timer = Timer.new()
	fade_timer.one_shot = true
	fade_timer.connect("timeout", Callable(self, "_on_fade_timeout"))
	add_child(fade_timer)

func _on_body_entered(body: Node2D) -> void:
	if body == Global.playerBody:
		# Inizia la dissolvenza in uscita
		fade_out()
		# Aspetta il tempo necessario e teletrasporta il giocatore
		fade_timer.start(fade_duration)

# Funzione per gestire la dissolvenza in uscita (fade out)
func fade_out() -> void:
	fade_out_progress = true
	fade_rect.visible = true  # Rendi visibile il ColorRect durante la dissolvenza
	var timer = 0.0
	while timer < fade_duration:
		timer += get_process_delta_time()
		fade_rect.modulate.a = lerp(0, 1, timer / fade_duration)
		# Aspetta un piccolo intervallo di tempo (0.01 secondi)
		await get_tree().create_timer(0.01).timeout

# Funzione per gestire la dissolvenza in entrata (fade in)
func fade_in() -> void:
	fade_in_progress = true
	var timer = 0.0
	while timer < fade_duration:
		timer += get_process_delta_time()
		fade_rect.modulate.a = lerp(1, 0, timer / fade_duration)
		# Aspetta un piccolo intervallo di tempo (0.01 secondi)
		await get_tree().create_timer(0.01).timeout
	# Dopo la dissolvenza, nascondi il ColorRect
	fade_rect.visible = false

# Funzione che verrà chiamata dal timer quando la dissolvenza è terminata
func _on_fade_timeout() -> void:
	if fade_out_progress:
		# Teletrasporta il giocatore
		Global.playerBody.position = teleport_position
		# Inizia la dissolvenza inversa
		fade_in()
		fade_out_progress = false
