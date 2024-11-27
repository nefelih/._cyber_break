extends State

const GRAVITY = 1500.0
const MOVE_SPEED = 400

var idle_state: State

func initialize():
	idle_state = get_parent().get_node("Idle")


func process_state(delta: float):
	#print("now moving")

	var direction = Input.get_axis("move_left", "move_right")
	if (Input.is_action_pressed("move_left") && (Input.is_action_pressed("move_right"))):
		direction = 1
		
	print(direction)
	if direction:
		if (body.is_on_floor()):
			body.velocity.x = direction * MOVE_SPEED
		else:
		#dampen effects of moving while in air
			body.velocity.x = direction * MOVE_SPEED/3
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, MOVE_SPEED)
	
	#if (Input.action_is_pressed("move_left")) || (Input.action_is_pressed("move_right")):
		#body.velocity.x = direction * MOVE_SPEED
		
	#body.move_and_slide()
	if (direction == 0):
		#body.velocity.x = 0
		change_state.emit(idle_state)
		
