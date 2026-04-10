extends Resource
class_name EnemyData

# thông tin cơ bản
@export var id: String
@export var display_name: String

# thông số chiến đấu
@export var max_hp: int = 10
@export var speed: float = 50
@export var damage: int = 1

# hình ảnh và hoạt ảnh
@export var texture: Texture2D
@export var animation_library: AnimationLibrary