extends Area2D

var speed: float = 0.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Di chuyển projectile về phía trước
	var velocity = direction * speed
	position += velocity * delta

	if rotation != direction.angle():
		rotation = direction.angle()  # Xoay projectile theo hướng di chuyển

# Xử lý va chạm với kẻ địch
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(2.0, self) # Gọi hàm take_damage trên kẻ địch, truyền vào lượng sát thương
		queue_free()  # Xóa projectile sau khi va chạm
