extends Node2D
class_name WeaponVisual

# Sprite hiển thị vũ khí
@export var sprite: Sprite2D
# Animation player của player
@export var animation_player: AnimationPlayer
# Player node
@export var player: CharacterBody2D

# Vũ khí hiện tại
var current_weapon: WeaponData = null
# Vị trí ban đầu
var base_position: Vector2 = Vector2.ZERO

func _ready():
	base_position = position
	
	# Lắng nghe signal từ WeaponManager
	WeaponManager.weapon_equipped.connect(_on_weapon_equipped)
	WeaponManager.weapon_unequipped.connect(_on_weapon_unequipped)
	
	# Ẩn sprite ban đầu
	sprite.visible = false

# Khi trang bị vũ khí
func _on_weapon_equipped(weapon: WeaponData):
	current_weapon = weapon
	sprite.texture = weapon.weapon_texture
	sprite.visible = true
	print("Hiển thị vũ khí: ", weapon.name)

# Khi tháo vũ khí
func _on_weapon_unequipped():
	current_weapon = null
	sprite.visible = false
	sprite.texture = null

# Cập nhật vị trí vũ khí dựa trên animation
func _process(delta):
	if current_weapon == null or sprite == null:
		return
	
	# Lấy animation hiện tại
	var current_anim = animation_player.current_animation
	var anim_progress = animation_player.current_animation_position / animation_player.current_animation_length
	
	# Nếu đang tấn công, dùng attack_offset
	if current_anim == current_weapon.attack_animation:
		position = base_position + current_weapon.attack_offset
	else:
		# Nếu idle, dùng idle_offset
		position = base_position + current_weapon.idle_offset
	
	# Lật vũ khí theo hướng player
	if player.last_direction == "side":
		sprite.flip_h = player.sprite_2d.flip_h
