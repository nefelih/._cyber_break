extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Exit.play("exit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_animation_finished() -> void:
	print("kapow")
	LevelNumber.next_level(0)
	get_tree().change_scene_to_file("res://levels/level2/scene_2.tscn")
