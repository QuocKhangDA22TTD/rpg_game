extends AttackBehavior
class_name MeleeAttack

func execute(user, weapon_data):
	# Lấy vị trí chuột trong world space thông qua user (Player)
	var mouse_pos = user.get_global_mouse_position()
	var player_pos = user.global_position
	
	# Tính vector từ nhân vật đến chuột
	var direction = (mouse_pos - player_pos).normalized()
	
	# Xác định hướng tấn công dựa trên góc
	var attack_direction: String
	var angle = atan2(direction.y, direction.x)
	
	# Chia thành 4 hướng: up, down, side (left/right)
	if angle > -PI/4 and angle < PI/4:
		# Hướng phải
		attack_direction = "side"
		user.sprite_2d.flip_h = false
		user.weapon_pivot.scale.x = 1
	elif angle > PI/4 and angle < 3*PI/4:
		# Hướng xuống
		attack_direction = "down"
		user.sprite_2d.flip_h = false
		user.weapon_pivot.scale.x = 1
	elif angle < -PI/4 and angle > -3*PI/4:
		# Hướng lên
		attack_direction = "up"
		user.sprite_2d.flip_h = false
		user.weapon_pivot.scale.x = 1
	else:
		# Hướng trái
		attack_direction = "side"
		user.sprite_2d.flip_h = true
		user.weapon_pivot.scale.x = -1
	
	# Hiển thị vũ khí
	user.weapon_sprite_2d.visible = true
	
	# Phát animation tấn công theo hướng
	var animation_name = "melee_attack_" + attack_direction
	user.animation_player.play(animation_name)
	
	# Chờ animation kết thúc rồi cập nhật last_direction
	await user.animation_player.animation_finished
	user.last_direction = attack_direction
	
	# Ẩn vũ khí sau khi tấn công kết thúc
	user.weapon_sprite_2d.visible = false


func handle_input(user, weapon_data, input_state):
	if input_state.just_pressed:
		execute(user, weapon_data)
