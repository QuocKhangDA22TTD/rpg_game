extends Node

# Signal phát ra khi trang bị vũ khí
signal weapon_equipped(weapon: WeaponData)
signal weapon_unequipped

# Vũ khí hiện tại đang trang bị
var current_weapon: WeaponData = null
# Thời gian còn lại của cooldown
var attack_cooldown_remaining: float = 0.0
# Có thể tấn công không
var can_attack: bool = true

func _process(delta):
	# Cập nhật cooldown
	if attack_cooldown_remaining > 0:
		attack_cooldown_remaining -= delta
		if attack_cooldown_remaining <= 0:
			can_attack = true

# Trang bị vũ khí
func equip_weapon(weapon: WeaponData):
	if weapon == null:
		unequip_weapon()
		return
	
	current_weapon = weapon
	can_attack = true
	attack_cooldown_remaining = 0.0
	weapon_equipped.emit(weapon)
	print("Trang bị: ", weapon.name)

# Tháo vũ khí
func unequip_weapon():
	current_weapon = null
	can_attack = true
	weapon_unequipped.emit()
	print("Tháo vũ khí")

# Thực hiện tấn công
func perform_attack() -> bool:
	if current_weapon == null or not can_attack:
		return false
	
	can_attack = false
	attack_cooldown_remaining = current_weapon.attack_cooldown
	print("Tấn công với: ", current_weapon.name, " - Sát thương: ", current_weapon.damage)
	return true

# Lấy vũ khí hiện tại
func get_current_weapon() -> WeaponData:
	return current_weapon

# Kiểm tra có thể tấn công không
func is_attack_ready() -> bool:
	return can_attack and current_weapon != null
