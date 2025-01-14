extends Node2D

var animation_count = 0
var switch = false
@onready var start_button = $Start

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if (start_button.is_pressed()):
		get_tree().change_scene_to_file("res://levels/screen_o_death.tscn")
		
