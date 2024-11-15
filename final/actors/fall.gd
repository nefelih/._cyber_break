extends State

const GRAVITY = 1500.0
const MOVE_SPEED = 300

var idle_state: State
var move_state: State

func initialize():
	idle_state = get_parent().get_node("Idle")
	move_state = get_parent().get_node("Move")

func process_state(delta: float):
	#print("falling now")
	if (!body.is_on_floor()):
		body.velocity.y += GRAVITY * delta
	else:
		if (Input.is_action_pressed("move_left") || (Input.is_action_pressed("move_right"))):
			change_state.emit(move_state)
		else:
			change_state.emit(idle_state)
		#body.move_and_slide()
	#else:
		#change_state.emit(idle_state)
