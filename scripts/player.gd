extends CharacterBody2D

@export var speed: float = 80.0
@export var camera_2d: Camera2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction: String = "down"

func _physics_process(delta: float) -> void:
	var input_vec = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	velocity = input_vec * speed
	move_and_slide()

	if input_vec != Vector2.ZERO:
		# ƯU TIÊN DI CHUYỂN NGANG
		if input_vec.x != 0:
			sprite.play("move_side")
			sprite.flip_h = input_vec.x < 0
			last_direction = "side"
		else:
			if input_vec.y > 0:
				sprite.play("move_down")
				last_direction = "down"
			else:
				sprite.play("move_up")
				last_direction = "up"
	else:
		# Idle theo hướng cuối
		if last_direction == "side":
			sprite.play("idle_side")
		elif last_direction == "up":
			sprite.play("idle_up")
		else:
			sprite.play("idle_down")

	global_position = global_position.round()
	camera_2d.global_position = global_position
