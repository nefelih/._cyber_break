extends Label

signal typing_finished

var pc: float

func _ready():
	visible_ratio = 0.0
	pc = 1.0 / text.length() # percent to add to the label each time the timer times out - with 150 characters this will give you 0.006667 per update, enough for 1 character per update.


func _on_timer_timeout() -> void:
	visible_ratio += pc
	if visible_ratio >= 1.0:
		$Timer.stop()
		typing_finished.emit()


func _on_what_typing_finished() -> void:
	$Timer.start()
