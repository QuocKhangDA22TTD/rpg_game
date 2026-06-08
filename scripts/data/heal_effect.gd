extends ConsumableEffect
class_name HealEffect

@export var heal_amount: int = 80 # Lượng máu được hồi khi sử dụng bình hồi máu

func apply_effect(player: CharacterBody2D) -> bool:
	if player.stats.current_health >= player.stats.max_health:
		return false # Nếu máu đã đầy thì không cho sử dụng bình hồi máu
	
	# Hồi máu nhưng không vượt quá máu tối đa
	player.stats.current_health = min(player.stats.current_health + heal_amount, player.stats.max_health)

	return true # Sử dụng thành công
