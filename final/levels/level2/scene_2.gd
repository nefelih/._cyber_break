extends Node2D

@export var level_start_pos = Node2D

var start_area : Area2D
var end_area : Area2D

@onready var player : Player = $Player

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	start_area = $Trigger
	end_area = $TheEnd
	
	$StaticBody2D/walking.disabled = true
	$Walking.visible = false
	
	$Pause/PauseMenu.visible = false
	Menu.paused.connect(transition)
	
func _physics_process(delta: float) -> void:
	var player = start_area.get_overlapping_bodies()
	var player_end = end_area.get_overlapping_bodies()

	if (not player.is_empty()):
		#print("hello")
		$StartingPage.visible = true
		$StartingPage.play("default")
	
	if (not player_end.is_empty()):
		print("going to the end")
		$EndAnimation.visible = true
		$EndAnimation.play("default")


func _on_end_animation_animation_finished() -> void:
	LevelNumber.next_level(0)
	get_tree().change_scene_to_file("res://levels/end/the_end.tscn")


func _on_starting_page_animation_finished() -> void:
	$StartingPage.visible = true
	$StaticBody2D/walking.disabled = false
	$Walking.visible = true


func _input(event):
	if (Input.is_action_just_pressed("pause")):
		Menu.update_action(0)
		$Pause/PauseMenu.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

func transition(action):
	if (action == 1):
		get_tree().change_scene_to_file("res://levels/start/start.tscn")
	if (action == 2):
		#print("yo")
		$Pause/PauseMenu.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
