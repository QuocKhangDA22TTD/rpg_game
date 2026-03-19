# Script cho vật phẩm rơi trên bản đồ
extends Node2D

# Dữ liệu vật phẩm
@export var item : ItemData
# Số lượng vật phẩm
@export var amount : int = 1
@export var pickup_delay : float = 0.5
@export var move_speed : float = 160.0

# Tham chiếu đến sprite hiển thị vật phẩm
@onready var sprite = $Sprite2D
# Tham chiếu đến vùng va chạm để nhặt vật phẩm
@onready var area = $Area2D

var can_pickup : bool = false
var target_player = null

# Khởi tạo vật phẩm rơi
func _ready():
	if item and item.icon:
		# Hiển thị icon của vật phẩm
		sprite.texture = item.icon
		
		# Điều chỉnh kích thước sprite nếu có thiết lập
		if item.world_scale > 0:
			sprite.scale = Vector2(item.world_scale, item.world_scale)
		
	await get_tree().create_timer(pickup_delay).timeout
	can_pickup = true

	# Kết nối signal khi có vật thể va chạm
	area.body_entered.connect(_on_body_entered)


func _process(delta):
	if target_player:
		# Di chuyển về player
		var direction = (target_player.global_position - global_position).normalized()
		global_position += direction * move_speed * delta
		
		# Kiểm tra đã chạm player chưa
		if global_position.distance_to(target_player.global_position) <= 5.0:
			if InventoryManager.add_item(item, amount):
				queue_free()



# Xử lý khi người chơi chạm vào vật phẩm
func _on_body_entered(body):	
	if body.name == "Player" and target_player == null:
		target_player = body
