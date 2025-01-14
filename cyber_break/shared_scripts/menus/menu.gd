extends Node

signal paused

var action : int = 0

func update_action(num : int):
	action = num
	paused.emit(action)
	
