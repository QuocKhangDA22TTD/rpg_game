extends Area2D
class_name Hurtbox

var enemy: CharacterBody2D

func _ready() -> void:
	enemy = get_parent()

# Hàm relay - chuyển tiếp từ Projectile → Enemy
func take_damage(amount: float, source = null) -> void:
	if enemy and enemy.has_method("take_damage"):
		enemy.take_damage(amount, source)
