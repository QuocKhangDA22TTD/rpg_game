extends Area2D
class_name Hitbox

# Signal phát ra khi va chạm với enemy
signal hit_enemy(enemy: Node2D)

# Danh sách số lần enemy đã bị hit để tránh hit nhiều lần
var hit_enemies: Array = []

func _ready() -> void:
	# Dùng body_entered thay vì area_entered vì enemy là CharacterBody2D
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Kiểm tra xem body có phải là enemy không
	if body.is_in_group("enemy") and body not in hit_enemies:
		hit_enemies.append(body)
		hit_enemy.emit(body)

# Gọi hàm này khi animation tấn công kết thúc để reset danh sách
func reset_hit_list() -> void:
	hit_enemies.clear()
