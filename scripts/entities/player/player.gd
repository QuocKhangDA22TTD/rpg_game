# Script điều khiển nhân vật người chơi
extends CharacterBody2D

# Tốc độ di chuyển của nhân vật
@export var speed: float = 80.0
# Tham chiếu đến camera theo dõi nhân vật
@export var camera_2d: Camera2D
# Tham chiếu đến animation player để phát hoạt ảnh
@export var animation_player: AnimationPlayer
# Tham chiếu đến sprite của nhân vật
@export var sprite_2d: Sprite2D
# Tham chiếu đến vũ khí đang được cầm
@export var current_weapon: WeaponData
# tham chiếu đến sprite cho vũ khí
@export var weapon_sprite_2d: Sprite2D
# tham chiếu đến điểm gốc để xoay vũ khí
@export var weapon_pivot: Node2D
# Tham chiếu đến sprite hiệu ứng tấn công
@export var effect_sprite_2d: Sprite2D
# Tham chiếu đến hitbox để xử lý va chạm tấn công
@export var hitbox: Hitbox

# Hướng cuối cùng nhân vật đang quay mặt
var last_direction: String = "down"
# Vector chứa input từ bàn phím
var input_vector := Vector2.ZERO

func _ready() -> void:
	GameManager.player = self

# Xử lý vật lý và di chuyển mỗi frame
func _physics_process(delta: float) -> void:
	input_vector = _get_input_vector()
	
	# Tính toán vận tốc dựa trên input và tốc độ
	velocity = input_vector * speed
	move_and_slide()
	
	# Xử lý input tấn công
	_handle_attack_input() 

	# Cập nhật hoạt ảnh và hướng nhân vật
	_update_animation_and_direction()
	
	# Làm tròn vị trí để tránh pixel lẻ
	global_position = global_position.round()
	# Camera theo dõi nhân vật
	camera_2d.global_position = global_position


# Lấy vector input từ bàn phím (WASD hoặc mũi tên)
func _get_input_vector():
	if animation_player.current_animation.begins_with("melee_attack"):
		return Vector2.ZERO  # Không nhận input di chuyển nếu đang tấn công
	
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)


# Cập nhật hoạt ảnh và hướng nhân vật dựa trên input
func _update_animation_and_direction():
	if animation_player.current_animation.begins_with("melee_attack"):
		return  # Không phát animation di chuyển nếu đang tấn công

	if input_vector != Vector2.ZERO:
		# Ưu tiên di chuyển ngang hơn dọc
		if input_vector.x != 0:
			animation_player.play("move_side")
			sprite_2d.flip_h = input_vector.x < 0  # Lật sprite khi đi sang trái
			last_direction = "side"
		else:
			if input_vector.y > 0:
				animation_player.play("move_down")
				last_direction = "down"
			else:
				animation_player.play("move_up")
				last_direction = "up"
	else:
		# Khi đứng yên, phát hoạt ảnh idle theo hướng cuối cùng
		match last_direction:
			"side":   animation_player.play("idle_side")
			"up":     animation_player.play("idle_up")
			_:        animation_player.play("idle_down")


func _handle_attack_input():
	if current_weapon == null or current_weapon.attack_behavior == null:
		return
		
	var input_state = AttackInputState.new()
	input_state.pressed = Input.is_action_pressed("attack")
	input_state.just_pressed = Input.is_action_just_pressed("attack")
	input_state.just_released = Input.is_action_just_released("attack")
	
	current_weapon.attack_behavior.handle_input(self, current_weapon, input_state)
