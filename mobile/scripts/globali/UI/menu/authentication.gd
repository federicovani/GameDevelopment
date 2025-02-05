extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Firebase.auth.login_succeeded.connect(on_login_succeeded)
	Firebase.auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.auth.login_failed.connect(on_login_failed)
	Firebase.auth.signup_failed.connect(on_signup_failed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


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
	
	
func on_signup_succeeded(auth):
	print(auth)
	%StateLabel.text = "Sign up success!"
	
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Login failed. Error: %s" % message
	
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Sign up failed. Error: %s" % message
