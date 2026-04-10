extends Resource
class_name EnemyData

# thông tin cơ bản
@export var id: String
@export var display_name: String

# thông số chiến đấu
@export var max_hp: int = 10
@export var speed: float = 50
@export var damage: int = 1

# thông tin hoạt ảnh
@export var animation_library: AnimationLibrary