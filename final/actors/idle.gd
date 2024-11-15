extends State

const GRAVITY = 1500.0
const MOVE_SPEED = 300

func initialize():
	body.velocity = Vector2(0,0)
	
func process_state(delta):
	body.velocity.x = move_toward(body.velocity.x, 0, MOVE_SPEED)
	body.velocity.y = move_toward(body.velocity.x, 0, MOVE_SPEED)
	
