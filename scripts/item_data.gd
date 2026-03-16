# Lớp dữ liệu cho vật phẩm trong game
extends Resource
class_name ItemData

# ID duy nhất của vật phẩm
@export var id : String
# Tên hiển thị của vật phẩm
@export var name : String
# Icon hiển thị trong UI
@export var icon : Texture2D
# Số lượng tối đa có thể xếp chồng trong 1 slot
@export var max_stack : int = 99
# Tỷ lệ kích thước khi hiển thị trên bản đồ
@export var world_scale : float = 0.0

# Enum định nghĩa các loại vật phẩm
enum ItemType {
	CONSUMABLE,  # Vật phẩm tiêu hao (thuốc, thức ăn...)
	MATERIAL,    # Nguyên liệu
	WEAPON,      # Vũ khí
	ARMOR        # Giáp
	}

# Loại vật phẩm
@export var type : ItemType
