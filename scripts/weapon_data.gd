extends ItemData
class_name WeaponData

@export var damage: float = 10.0		# sát thương cơ bản của vũ khí
@export var attack_speed: float = 1.0	# tốc độ tấn công (số lần tấn công mỗi giây)

@export var crit_chance: float = 0.1	# xác suất chí mạng
@export var crit_damage: float = 1.5	# hệ số sát thương chí mạng

@export var mana_cost: float = 0.0		# lượng mana tiêu thụ mỗi lần tấn công

@export var weapon_texture: Texture2D	# texture của vũ khí

@export var attack_behavior: AttackBehavior	# hành vi tấn công của vũ khí

@export var effect_offset: Vector2 = Vector2.ZERO # vị trí hiệu ứng tấn công so với điểm pivot của vũ khí
