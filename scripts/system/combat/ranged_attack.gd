extends AttackBehavior
class_name RangedAttack

var current_weapon_data: WeaponData # Lưu trữ WeaponData hiện tại để sử dụng trong hàm xử lý va chạm

func execute(user, weapon_data):
	pass


func handle_input(user, weapon_data, input_state):
	if input_state.just_pressed:
		execute(user, weapon_data)
