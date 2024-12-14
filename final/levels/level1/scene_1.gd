extends Node2D
#in windows 95 black terminal still
#figure out what camera view looks the best for this situation
#^ implementing camera jitter as it follows the player -> moving to camera.gd script

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

func _ready() -> void:
	$Transition.visible = false
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

func _physics_process(delta: float) -> void:
	var player = stop_area.get_overlapping_bodies()
	var player_disappear =  disappear_area.get_overlapping_bodies()
	var player_reset = pit_area.get_overlapping_bodies()
	var player_exit = final_glitch.get_overlapping_bodies()
	var player_transition = exit.get_overlapping_bodies()
	
	#print(player)
	if (not player.is_empty() && stop_animation == false):
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
		
	if (not player_exit.is_empty() && ($Stop.visible == true)):
		$Stop.play("default")
		
	if (not player_transition.is_empty() && (exit_animation == false)):
		exit_animation = true
		print("WE'RE DOING IT")
		$Transition.visible = true
		$Transition.play("exit")

		
		
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


func _on_transition_animation_finished() -> void:
	print("changing level")
	#LevelNumber.next_level(1)
	get_tree().change_scene_to_file("res://levels/level2/scene_2.tscn")
