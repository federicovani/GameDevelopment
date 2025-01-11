extends Control

@onready var audio_name_lbl: Label = $HBoxContainer/AudioNameLbl
@onready var audio_value_lbl: Label = $HBoxContainer/AudioValueLbl
@onready var slider: HSlider = $HBoxContainer/HSlider

@export_enum("Master", "Music", "SFX") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	get_bus_name_by_index()
	load_data()
	set_name_label_text()
	set_slider_value()

func load_data():
	match bus_name:
		"Master":
			on_value_changed(SettingsDataContainer.get_master_volume())
		"Music":
			on_value_changed(SettingsDataContainer.get_music_volume())
		"SFX":
			on_value_changed(SettingsDataContainer.get_sfx_volume())

func set_name_label_text():
	audio_name_lbl.text = str(bus_name) + " Volume"

func set_audio_value_label_text():
	audio_value_lbl.text = str(slider.value * 100) + "%"

func get_bus_name_by_index():
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value():
	slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_value_label_text()

func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_value_label_text()
	
	match bus_index:
		0:
			SettingsSignalBus.emit_on_master_sound_set(value)
		1:
			SettingsSignalBus.emit_on_music_sound_set(value)
		2:
			SettingsSignalBus.emit_on_sfx_sound_set(value)
