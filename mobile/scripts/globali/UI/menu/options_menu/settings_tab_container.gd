class_name SettingTabContainer extends Control

@onready var tab_container: TabContainer = $TabContainer

signal exit_options_menu

func _process(delta: float) -> void:
	option_menu_inputs()

func change_tab(tab : int):
	tab_container.set_current_tab(tab)

func option_menu_inputs():
	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		if tab_container.current_tab >= tab_container.get_tab_count() - 1:
			change_tab(0)
			return
		var next_tab = tab_container.current_tab + 1
		change_tab(next_tab)
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("ui_left"):
		if tab_container.current_tab == 0:
			var last_tab = tab_container.get_tab_count() - 1
			change_tab(last_tab)
			return
		var previous_tab = tab_container.current_tab - 1
		change_tab(previous_tab)		
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("ui_cancel"):
		exit_options_menu.emit()
