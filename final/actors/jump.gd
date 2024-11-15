extends State

const GRAVITY = 1500.0
const MOVE_SPEED = 300
const FRICTION = 800.0

var fallMultiplier = 2 
var lowJumpMultiplier = 10 

func initialize():
	pass

func process_state(delta: float):
	body.velocity.y = -900
	var direction = Input.get_axis("move_left", "move_right")
	body.velocity.x += direction * 150 * delta
	
	if (Input.get_axis("move_left", "move_right") != 0):
		direction = 0

	#body.move_and_slide()

		
	
		
	##Applying gravity to player
	#body.velocity.y += gravity 
	#
	##Jump Physics
	#if body.velocity.y > 0: #Player is falling
		#body.velocity += Vector2.UP * (-9.81) * (fallMultiplier) #Falling action is faster than jumping action | Like in mario
#
	#elif body.velocity.y < 0 && Input.is_action_just_released("jump"): #Player is jumping 
		#body.velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier) #Jump Height depends on how long you will hold key
#
	#if body.is_on_floor():
		#if Input.is_action_just_pressed("jump"): 
			#body.velocity = Vector2.UP * 400 #Normal Jump action
			#body.move_and_slide()
