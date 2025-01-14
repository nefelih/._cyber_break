extends Label

signal typing_finished

var pc : float
#@export var Typewriter : Area2D
#@onready var start_typing : Area2D = get_parent().get_node("Typewritter")

func _ready():
	visible_ratio = 0.0
	pc = 1.0 / text.length() # percent to add to the label each time the timer times out - with 150 characters this will give you 0.006667 per update, enough for 1 character per update.
	$Timer.start()
	
##func _physics_process(delta: float) -> void:
	#var player = Typewriter.get_overlapping_bodies()
	#
	#if (not player.is_empty()):
		#$Timer.start()


func _on_timer_timeout() -> void:
	visible_ratio += pc
	if visible_ratio >= 1.0:
		$Timer.stop()
		typing_finished.emit()
