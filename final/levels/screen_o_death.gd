extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#cursor go away

func _input(event: InputEvent) -> void:
	if (Input.is_anything_pressed()):
		print("starting the game ...")
		#get_tree().change_scene_to_file("res://levels/transition_1.tscn")
	#can't exit at this point, no esc to options pop up
	#ignoring the transition rn for debugging purposes
		get_tree().change_scene_to_file("res://levels/scene_1.tscn")
