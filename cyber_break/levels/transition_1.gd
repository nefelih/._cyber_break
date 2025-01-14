extends Node2D

var animation_count = 0
var switch = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Glitch.play("glitch")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#cursor go away
	

func _on_glitch_animation_finished() -> void:
	print("animation count: ", animation_count)
	
	if (animation_count == 0):
		print("glitch1")
		$Glitch.play("glitch1")
		
	if (animation_count == 1):
		print("glitch2")
		$Glitch.play("glitch2")
		
	if (animation_count == 2):
		print("glitch3")
		$Glitch.play("glitch3")
		
	if (animation_count == 3):
		print("screen crash finished")
		LevelNumber.next_level(0)
		get_tree().change_scene_to_file("res://levels/level1/scene_1.tscn")

	animation_count += 1
