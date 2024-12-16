extends Node2D

@export var bg_music : Resource
@export var bg_music_2 : Resource

var animation_count = 0
var switch = false
@onready var start_button = $Start

func _ready() -> void:
	$Desktop2.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalAudioManager.play_track(bg_music, 0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (start_button.is_pressed()):
		start_button.visible = false
		

func _input(event: InputEvent) -> void:
	if (Input.is_anything_pressed()):
		print("first transition")
		$Desktop.stop()
		$Desktop2.visible = true
		$Desktop2.play("transition")
		GlobalAudioManager.play_track(bg_music_2, 0.5)
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_desktop_2_animation_finished() -> void:
	get_tree().change_scene_to_file("res://levels/screen_o_death.tscn")
