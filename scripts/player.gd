extends CharacterBody2D

@export var speed: float = 80.0
@export var camera_2d: Camera2D
@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D

var last_direction: String = "down"
var input_vector := Vector2.ZERO

func _ready() -> void:
	GameManager.register_player(self)

func _physics_process(delta: float) -> void:
	input_vector = _get_input_vector()
	
	velocity = input_vector * speed
	move_and_slide()
	
	_update_animation_and_direction()
	
	global_position = global_position.round()
	camera_2d.global_position = global_position


func _get_input_vector():
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)


func _update_animation_and_direction():
	if input_vector != Vector2.ZERO:
		if input_vector.x != 0:   # ngang mạnh hơn dọc
			animation_player.play("move_side")
			sprite_2d.flip_h = input_vector.x < 0
			last_direction = "side"
		else:
			if input_vector.y > 0:
				animation_player.play("move_down")
				last_direction = "down"
			else:
				animation_player.play("move_up")
				last_direction = "up"
	else:
		match last_direction:
			"side":   animation_player.play("idle_side")
			"up":     animation_player.play("idle_up")
			_:        animation_player.play("idle_down")
