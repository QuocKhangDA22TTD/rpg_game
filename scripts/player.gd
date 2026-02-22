extends CharacterBody2D

func _physics_process(delta: float) -> void:
	velocity = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"),
	) * 60.0
	
	move_and_slide()
