extends Resource
class_name LevelStatsData

var level_to_unlocked : Dictionary

var level_to_stats : Dictionary

func save_level_to_unlocked(unlocked_level : Dictionary):
	level_to_unlocked = unlocked_level

func get_level_to_unlocked() -> Dictionary:
	return level_to_unlocked

func save_level_stats(level_stats : Dictionary):
	level_to_stats = level_stats

func get_level_stats_dictionary() -> Dictionary:
	return level_to_stats
