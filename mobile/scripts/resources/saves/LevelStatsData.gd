extends Resource
class_name LevelStatsData

@export var level_to_completed : Dictionary

@export var level_to_unlocked : Dictionary

@export var level_to_stats : Dictionary

func save_level_to_completed(completed_level : Dictionary):
	level_to_completed = completed_level

func get_level_to_completed() -> Dictionary:
	return level_to_completed


func save_level_to_unlocked(unlocked_level : Dictionary):
	level_to_unlocked = unlocked_level

func get_level_to_unlocked() -> Dictionary:
	return level_to_unlocked


func save_level_stats(level_stats : Dictionary):
	level_to_stats = level_stats

func get_level_stats_dictionary() -> Dictionary:
	return level_to_stats
