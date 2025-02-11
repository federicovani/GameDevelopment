extends MarginContainer
class_name StatsContainer

@onready var time_label: Label = $VBoxContainer/Time
@onready var death_label: Label = $VBoxContainer/Death

@export var diamonds_array : Array[Node]

var diamonds : int
var time : float
var deaths : int

func get_level_stats(level : String):
	var stats : Dictionary
	stats = LevelStats.level_to_stats.get(level)
	diamonds = stats.get("diamonds")
	time = stats.get("time")
	deaths = stats.get("deaths")
	update_leve_completed_stats()

func update_leve_completed_stats():
	#Diamonds:
	for i in 3:
		if(i < diamonds):
			diamonds_array[i].show()
			diamonds_array[i+3].hide()
		else:
			diamonds_array[i].hide()
			diamonds_array[i+3].show()
	
	#Time
	time_label.text = "Time: " + time_convert(int(time))
	#Deaths
	death_label.text = "Deaths: " + str(deaths)

func time_convert(time : int):
	var seconds = time%60
	var minutes = (time/60)%60
	
	#returns a string with the format "MM:SS"
	return "%02d:%02d" % [minutes, seconds]
