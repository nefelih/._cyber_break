extends Node

signal level_change

var current_level : int = 0

func next_level(num : int) -> void:
	print("CURRENT LEVEL / LVL NUM: ", current_level)
	current_level += num
	level_change.emit(current_level)
	print("CURRENT LEVEL / LVL NUM: ", current_level)
	
	if (current_level < 0):
		print("something's wrong with levels")
		get_tree().change_scene_to_file("res://levels/screen_o_death.tscn")
		
