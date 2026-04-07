# scripts/inventory/weapon_data.gd
extends ItemData
class_name WeaponData

@export var damage: float = 10.0		# Sát thương của vũ khí
@export var weapon_texture: Texture2D	# Texture vũ khí khi trang bị
@export var attack_speed: float = 1.0   # số đòn/giây
@export var range: float = 50.0         # tầm đánh
@export var crit_chance: float = 0.1    # % chí mạng
@export var crit_damage: float = 1.5    # Tỷ lệ chí mạng

@export var knockback: float = 0.0		# Lực đẩy lùi khi đánh trúng kẻ địch
@export var stun_time: float = 0.0		# Thời gian làm choáng kẻ địch khi đánh trúng
@export var status_effect: String = ""	# Hiệu ứng trạng thái đặc biệt khi đánh trúng kẻ địch

@export var mana_cost: float = 0.0 		# Lượng mana tiêu hao khi sử dụng vũ khí

@export var projectile_scene: PackedScene		# scene vật thể bay (dành cho vũ khí tầm xa)
@export var projectile_speed: float = 300.0		# Tốc độ bay của vật thể (dành cho vũ khí tầm xa)

@export var hit_effect: PackedScene		# Hiệu ứng khi đánh trúng kẻ địch
@export var attack_sound: AudioStream	# Âm thanh khi tấn công với vũ khí

@export var strength_scaling: float = 1.0	# Tỷ lệ ảnh hưởng của sức mạnh player lên sát thương
@export var agility_scaling: float = 0.0	# Tỷ lệ ảnh hưởng của nhanh nhẹn player lên sát thương

enum WeaponType {
    MELEE,
    RANGED,
    MAGIC
}

@export var weapon_type: WeaponType
