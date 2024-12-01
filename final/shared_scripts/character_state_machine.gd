extends CharacterBody2D

class_name CharacterStateMachine


@onready var idle_sprite = $MainSprite
@export var initial_state : State
@onready var current_state : State = initial_state
# Storage of all states in machine
var all_states : Array[State]
	
func _ready():
	for child in $States.get_children():
		if (child is State):
			all_states.append(child)
			child.change_state.connect(on_change_state)
			
			child.body = self
			child.initialize()
		else:
			push_warning("child " + child.name + " is not a state for " + self.name)
			

	initialize()
	
func initialize():
	pass
	
func _physics_process(delta: float) -> void:
	current_state.process_state(delta)
	#print(current_state)
	
	
func on_change_state(next_state: State):
	current_state.on_exit_state()
	current_state = next_state
	current_state.on_enter_state()
		
	
	
