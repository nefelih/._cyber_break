extends Area2D

#signal body entered

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.handle_death()
		
