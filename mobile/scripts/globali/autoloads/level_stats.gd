extends Node

var time : float = 0
var deaths : int = 0
var coins : int = 0
var diamonds : int = 0
var checkpoint_taken : bool = false

var stats : Dictionary = {
	"time" : 0.0,
	"deaths" : 0,
	"coins" : 0,
	"diamonds" : 0,
	"checkpoint_taken" : false
}

var level_to_stats : Dictionary = {
	SceneManager.tutorial : stats,
	SceneManager.livello_federico : stats,
	SceneManager.livello_elisa : stats,
	SceneManager.livello_sara : stats
}

func _ready() -> void:
	SignalBus.connect("level_changed", _on_level_changed)
	SignalBus.connect("on_coin_collected", _on_coin_collected)
	SignalBus.connect("diamond_collected", _on_diamond_collected)
	SignalBus.connect("checkpoint_taken", _on_checkpoint_taken)
	SignalBus.connect("new_death", _on_new_death)
	SignalBus.connect("portal_crossed", _on_portal_crossed)

func _process(delta: float) -> void:
	time += delta

func _on_level_changed():
	time = 0
	deaths = 0
	coins = 0
	diamonds = 0
	checkpoint_taken = false

func _on_coin_collected(value : int):
	coins += value

func _on_diamond_collected():
	diamonds += 1

func _on_checkpoint_taken():
	checkpoint_taken = true

func is_checkpoint_taken() -> bool:
	return checkpoint_taken

func _on_new_death():
	deaths += 1

func _on_portal_crossed():
	save_level_to_stats_dictionary()
	SignalBus.emit_save_level_stats()
	save_on_db()
	SignalBus.emit_update_level_stats_ui(time, deaths, coins, diamonds)

func save_level_to_stats_dictionary():
	save_stats_dictionary()
	if(level_to_stats.has(SceneManager.current_scene_to_var())):
		level_to_stats[SceneManager.current_scene_to_var()] = stats

func save_stats_dictionary():
	stats["time"] = time
	stats["deaths"] = deaths
	stats["coins"] = coins
	stats["diamonds"] = diamonds
	stats["checkpoint_taken"] = checkpoint_taken

func save_on_db():
	var auth = Firebase.Auth.auth
	if auth.has("localid"):
		var local_id = auth["localid"]
		var saved = 0
		
		var level_subcollection_name = "level_" + str(Global.current_level_selected)
		var document_path = "users/" + local_id + "/" + level_subcollection_name
		var level_subcollection = Firebase.Firestore.collection(document_path)
		
		while(!saved):
			var doc_id = generate_random_id(16)
		
			if(Firebase.Firestore.collection(document_path + "/" + doc_id) != null):
				level_subcollection.add(doc_id, stats)
				saved = 1
				print_debug("level stats saved on db")
			else:
				print_debug("Error")
		
func generate_random_id(length: int) -> String:
	var rng = RandomNumberGenerator.new()
	rng.randomize() 
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var id = ""
	
	for i in range(length):
		var random_char = characters[rng.randi_range(0, characters.length() - 1)]
		id += random_char
	return id
