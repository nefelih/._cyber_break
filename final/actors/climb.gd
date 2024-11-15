extends State

#use code below for climbing state
#was the moving code, but climb uses all four directions
	#body.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	#body.move_and_slide()
	#if body.velocity.x == 0 :
		#change_state.emit(idle_state)
