# Script cho vật phẩm rơi trên bản đồ
extends Node2D

# Dữ liệu vật phẩm
@export var item : ItemData
# Số lượng vật phẩm
@export var amount : int = 1

# Tham chiếu đến sprite hiển thị vật phẩm
@onready var sprite = $Sprite2D
# Tham chiếu đến vùng va chạm để nhặt vật phẩm
@onready var area = $Area2D

# Khởi tạo vật phẩm rơi
func _ready():
	if item and item.icon:
		# Hiển thị icon của vật phẩm
		sprite.texture = item.icon
		
		# Điều chỉnh kích thước sprite nếu có thiết lập
		if item.world_scale > 0:
			sprite.scale = Vector2(item.world_scale, item.world_scale)
		
	# Kết nối signal khi có vật thể va chạm
	area.body_entered.connect(_on_body_entered)


# Xử lý khi người chơi chạm vào vật phẩm
func _on_body_entered(body):
	if body.name == "Player":
		# Thử thêm vật phẩm vào kho đồ
		if GameManager.inventory.add_item(item, amount):
			# Nếu thêm thành công, xóa vật phẩm khỏi bản đồ
			queue_free()
