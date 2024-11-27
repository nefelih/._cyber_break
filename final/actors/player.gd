extends CharacterStateMachine

class_name Player

var jump_state: State
var move_state: State
var fall_state: State
var idle_state: State

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
	#current_state = idle_state
	
func _physics_process(delta: float) -> void:
	current_state.process_state(delta)
	#print(current_state)
	
	if (!is_on_floor()):
		#falling
		#print("changing -> fall")
		on_change_state(fall_state)
	
	if (is_on_floor()) && (Input.is_action_just_pressed("jump")):
		#jumping
		#print("changing -> jump")
		on_change_state(jump_state)
	
	if (Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right")):
		#moving back and forth
		#print("changing -> move")
		on_change_state(move_state)
	
	move_and_slide()
	
#make a climbing function -> if hitting an object in a group "climbable" do things
