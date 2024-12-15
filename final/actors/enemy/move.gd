extends State

const MOVE_SPEED : int = 100


var up : bool = true
var movement : int = 0

func initialize():
	pass

func process_state(delta: float):
	
	if up:
		body.velocity = Vector2.UP * MOVE_SPEED
		await get_tree().create_timer(1).timeout
		up = false
		body.move_and_slide()

		
	if !up:
		body.velocity = Vector2.DOWN * MOVE_SPEED
		await get_tree().create_timer(1).timeout
		up = true
		body.move_and_slide()
		#print("moving down")
	
	body.velocity = Vector2.ZERO
