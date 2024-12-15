extends Node2D
#in windows 95 black terminal still
#figure out what camera view looks the best for this situation
#^ implementing camera jitter as it follows the player -> moving to camera.gd script

@export var mouse_cursor : Resource
@export var pause_menu: PackedScene

var stop_area : Area2D
var stop_animation : bool = false
var disappear_area : Area2D
var disappear : bool = true
var pit_area : Area2D
var final_glitch : Area2D
var exit : Area2D
var exit_animation : bool = false

var stop_count = 0
var camera : Camera2D
@export var level_start_pos = Node2D

@onready var player : Player = $Player

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#Input.set_custom_mouse_cursor(mouse_cursor)
	
	$Stop.visible = false
	
	$StopMovingSprite.visible = false
	$StaticBody2D/nethack.disabled = true
	
	$Text/Stop.visible = false
	$StaticBody2D/stop.disabled = true
	
	$Mimic.visible = true
	$Text/NetHack.visible = false
	$Text/Github.visible = false
	
	camera = $Player/Camera

	stop_area = $TriggerAnimation1
	disappear_area = $Disappear
	pit_area = $Pit
	final_glitch = $Glitch
	exit = $Exit
	
	$Pause/PauseMenu.visible = false
	Menu.paused.connect(transition)

func _physics_process(delta: float) -> void:
	var player = stop_area.get_overlapping_bodies()
	var player_disappear =  disappear_area.get_overlapping_bodies()
	var player_reset = pit_area.get_overlapping_bodies()
	var player_exit = final_glitch.get_overlapping_bodies()
	var player_transition = exit.get_overlapping_bodies()
	
	#print(player)
	if (not player.is_empty() && stop_animation == false):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		stop_animation = true
		$StopMovingSprite.visible = true
		$StopMovingSprite.play("stop")
	
	if (not player_disappear.is_empty() && disappear == true):
		$Player.velocity.x = 0
		#camera.set_offset(Vector2(0, 1100))
		camera.offset.y = 1100
		#camera.limit_right = 5500
		$StaticBody2D/nethack.disabled = false
		$Mimic.visible = false
		$Text/NetHack.visible = true
		$Text/Github.visible = true
		$Stop.visible = true
	
	if (not player_reset.is_empty()):
		await get_tree().create_timer(1).timeout
		camera.offset.y = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if (not player_exit.is_empty() && ($Stop.visible == true)):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		$Stop.play("default")
		
	if (not player_transition.is_empty() && (exit_animation == false)):
		exit_animation = true
		print("WE'RE DOING IT")
#		changing level
		LevelNumber.next_level(0)
		get_tree().change_scene_to_file("res://levels/transition_2.tscn")
		#$Transition.visible = true
		#$Transition.play("exit")
		#$Text/Stop.visible = false
		#$Text/NetHack.visible = false

		
func _on_stop_moving_sprite_animation_finished() -> void:
	#print("stop moving loop starting")
	$StopMovingSprite.play("loop")


func _on_stop_animation_looped() -> void:
	print(stop_count)
	stop_count += 1
	if (stop_count == 3):
		$Stop.visible = false
		$Stop.stop()
		$Text/Stop.visible = true
		$StaticBody2D/stop.disabled = false
		
		
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
