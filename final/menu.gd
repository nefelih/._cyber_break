extends Node2D

@onready var exit = $ExitButton
@onready var exit2 = $ExitButton2
@onready var exit3 = $ExitButton3
@onready var exit4 = $ExitButton4
@onready var resume = $ResumeButton
@onready var controls = $ControlsButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (exit.is_pressed() || exit2.is_pressed() || exit3.is_pressed() || exit4.is_pressed()):
		print("go back to starting menu")
		
	if (resume.is_pressed()):
		print("go back to scene")
		
	if (controls.is_pressed()):
		print("new controls pop up, needs an exit button")
