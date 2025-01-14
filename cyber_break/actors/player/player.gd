extends CharacterStateMachine

class_name Player

var can_control : bool = true

var forward = Vector2(1,1).normalized()
@export var speed: float  = 3.0
@export var max_speed: float = 10.0

var jump_state: State
var move_state: State
var fall_state: State
var idle_state: State

var coyote_frames = 20
var coyote = false
var last_floor = false
	

const GRAVITY = 1500.0
const MOVE_SPEED = 300

@export var hp: int = 3

func hit(damage_number: int):
	hp -= damage_number
	if (hp <= 0):
		
		queue_free()

func initialize():
	jump_state = $States/Jump
	move_state = $States/Move
	fall_state = $States/Fall
	idle_state = $States/Idle
	$CoyoteTimer.wait_time = coyote_frames / 60.0
	LevelNumber.level_change.connect(respawn)
	Menu.paused.connect(handle_pause)
	
	#current_state = idle_state
	
func _physics_process(delta: float) -> void:
	if not can_control: return
	
	move_and_slide()
	current_state.process_state(delta)
	#print(position)
	#print(current_state)
	
	if (!is_on_floor()):
		#falling
		#print("changing -> fall")
		on_change_state(fall_state)
	
	if ((is_on_floor()) || coyote) && (Input.is_action_just_pressed("jump")):
		#jumping
		#print("changing -> jump")
		on_change_state(jump_state)
	
	if (Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right")):
		#moving back and forth
		#print("changing -> move")
		on_change_state(move_state)	
		
	if !is_on_floor() and last_floor:
		coyote = true
		$CoyoteTimer.start()
			
	last_floor = is_on_floor()
	
#make a climbing function -> if hitting an object in a group "climbable" do things, maybe just change this to wall-jump

func _on_coyote_timer_timeout() -> void:
	coyote = false


func handle_death() -> void:
	print("player died")
	visible = false
	can_control = false
	
	#wait for timer to time out
	await get_tree().create_timer(1).timeout
	#resetting the player
	respawn(LevelNumber.current_level)
	
func respawn(level_num : int) -> void:
	print("LEVEL NUMBER: ", level_num)
	var levels = get_tree().get_nodes_in_group("levels")
	print(levels)
	velocity = Vector2(0,0)
	global_position = levels[0].level_start_pos.global_position
	visible = true
	can_control = true
	
	
func handle_pause(action):
	can_control = false
	
	if (action == 1):
		pass
#		navigate the scene tree to go to title card
	if (action == 2):
		can_control = true
		
	if (action == 3):
		pass
		
	
	
