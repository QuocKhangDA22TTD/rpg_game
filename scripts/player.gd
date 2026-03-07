extends CharacterBody2D

@export var speed: float = 80.0
@export var camera_2d: Camera2D

@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D

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
			animation_player.play("move_side")
			sprite_2d.flip_h = input_vec.x < 0
			last_direction = "side"
		else:
			if input_vec.y > 0:
				animation_player.play("move_down")
				last_direction = "down"
			else:
				animation_player.play("move_up")
				last_direction = "up"
	else:
		# Idle theo hướng cuối
		if last_direction == "side":
			animation_player.play("idle_side")
		elif last_direction == "up":
			animation_player.play("idle_up")
		else:
			animation_player.play("idle_down")

	global_position = global_position.round()
	camera_2d.global_position = global_position
