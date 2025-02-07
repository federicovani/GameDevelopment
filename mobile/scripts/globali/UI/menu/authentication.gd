extends Control

@onready var login: Button = $MarginContainer/VBoxContainer/ButtonsContainer/MarginContainer/VBoxContainer/LoginButton
@onready var signup: Button = $MarginContainer/VBoxContainer/ButtonsContainer/MarginContainer/VBoxContainer/SignupButton
@onready var back: Button = $MarginContainer/VBoxContainer/ButtonsContainer/MarginContainer/VBoxContainer/BackButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		%StateLabel.text = "Logged in"
		get_tree().change_scene_to_file("res://scenes/globali/UI/menu/main_menu.tscn")


func _process(delta: float) -> void:
	update_button_scale()


func _on_login_button_pressed() -> void:
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%StateLabel.text = "Logging in"


func _on_signup_button_pressed() -> void:
	var email = %EmailLineEdit.text
	var password = %PasswordLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StateLabel.text = "Signing up"
	

func on_login_succeeded(auth):
	print(auth)
	%StateLabel.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://scenes/globali/UI/menu/main_menu.tscn")
	
	
func on_signup_succeeded(auth):
	print(auth)
	%StateLabel.text = "Sign up success!"
	Firebase.Auth.save_auth(auth)
	add_user(auth)
	get_tree().change_scene_to_file("res://scenes/globali/UI/menu/main_menu.tscn")
	
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Login failed. Error: %s" % message
	
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Sign up failed. Error: %s" % message
	
	
func add_user(auth_data: Dictionary):
	var auth = Firebase.Auth.auth
	if auth.has("localid") and auth_data.has("email"):
		var local_id = auth["localid"]
		var email = auth_data["email"]
		# Accedi alla collection "utenti" e seleziona il documento identificato da local_id
		var collection = Firebase.Firestore.collection("users")
		
		# Crea il dizionario con l'email presa dal nodo EmailLineEdit
		var data: Dictionary = {
			"email": email
		}
		
		# Usa il metodo 'add' per creare il documento
		collection.add(local_id, data)

func _on_back_button_pressed() -> void:
	SceneManager.go_to_main_menu()

func update_button_scale():
	button_hover(login, 1.15, 0.2)
	button_hover(signup, 1.15, 0.2)
	button_hover(back, 1.15, 0.2)

func button_hover(button : Button, tween_amt, duration):
	button.pivot_offset = button.size / 2
	if button.is_hovered():
		tween(button, "scale", Vector2.ONE * tween_amt, duration)
	else:
		tween(button, "scale", Vector2.ONE, duration)

func tween(button, property, amount, duration):
	var tween = create_tween()
	tween.tween_property(button, property, amount, duration)
