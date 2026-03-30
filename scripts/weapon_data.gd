# scripts/inventory/weapon_data.gd
extends ItemData
class_name WeaponData

# Sát thương của vũ khí
@export var damage: float = 10.0
# Texture vũ khí khi trang bị
@export var weapon_texture: Texture2D

func _init(id = "", name = "", icon = null, weapon_texture = null, damage = 10.0):
	self.id = id
	self.name = name
	self.icon = icon
	self.weapon_texture = weapon_texture
	self.damage = damage
	self.type = ItemType.WEAPON
	self.max_stack = 1
