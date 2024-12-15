extends CanvasLayer

@onready var exit = $ExitButton
@onready var exit2 = $ExitButton2
@onready var exit3 = $ExitButton3
@onready var exit4 = $ExitButton4
@onready var resume = $ResumeButton
@onready var controls = $ControlsButton
@onready var player = get_tree().get_nodes_in_group("player")


func _ready() -> void:
	$Controls.visible = false

func _process(delta: float) -> void:
	
	if (exit.is_pressed() || exit2.is_pressed() || exit3.is_pressed() || exit4.is_pressed()):
		#print("go back to starting menu")
		Menu.update_action(1)
		$Controls.visible = false
		
	if (resume.is_pressed()):
		#print("go back to scene")
		Menu.update_action(2)
		$Controls.visible = false
		
	if (controls.is_pressed()):
		#print("new controls pop up, needs an exit button (just do invisib)")
		Menu.update_action(3)
		$Controls.visible = true
		
