extends CharacterBody2D

@export var speed: float = 160.0
@export var camera_2d: Camera2D

func _physics_process(delta: float) -> void:
	var input_vec = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	velocity = input_vec * speed
	move_and_slide()

	global_position = global_position.round()
	camera_2d.global_position = global_position
