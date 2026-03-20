# scripts/inventory/weapon_data.gd
extends ItemData
class_name WeaponData

# Sát thương của vũ khí
@export var damage: float = 10.0
# Tầm tấn công (pixel)
@export var range: float = 20.0
# Thời gian cooldown giữa các đòn tấn công (giây)
@export var attack_cooldown: float = 0.5
# Texture vũ khí khi trang bị
@export var weapon_texture: Texture2D
# Offset vị trí vũ khí so với player (khi idle)
@export var idle_offset: Vector2 = Vector2(10, 0)
# Offset vị trí vũ khí khi tấn công
@export var attack_offset: Vector2 = Vector2(15, 0)
# Tên animation tấn công (ví dụ: "swing_side")
@export var attack_animation: String = "swing_side"

func _init(id = "", name = "", icon = null, weapon_texture = null, damage = 10.0, range = 20.0, cooldown = 0.5):
	self.id = id
	self.name = name
	self.icon = icon
	self.weapon_texture = weapon_texture
	self.damage = damage
	self.range = range
	self.attack_cooldown = cooldown
	self.type = ItemType.WEAPON
	self.max_stack = 1
