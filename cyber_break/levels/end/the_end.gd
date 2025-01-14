extends Node2D

var boring_area : Area2D
var good_area : Area2D

@export var level_start_pos = Node2D

@onready var player : Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	boring_area = $BoringEnding
	good_area = $GoodEnding
	
	$Pause/PauseMenu.visible = false
	Menu.paused.connect(transition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_boring = boring_area.get_overlapping_bodies()
	var player_good = good_area.get_overlapping_bodies()
	
	if (not player_boring.is_empty()):
		$BoringTransition.visible = true
		$BoringTransition.play("default")

	if (not player_good.is_empty()):
		$GoodTransition.visible = true
		$GoodTransition.play("default")
		
		
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


func _on_boring_transition_animation_finished() -> void:
	get_tree().change_scene_to_file("res://levels/start/start.tscn")


func _on_good_transition_animation_finished() -> void:
	get_tree().change_scene_to_file("res://levels/end/good_ending.tscn")
