extends EnemyState
class_name AttackState

var timer := 0.0
var duration := 0.05
var has_dashed := false

func enter(enemy):
	timer = duration
	has_dashed = false
	enemy.velocity = Vector2.ZERO
	enemy.play_anim("attack")

func update(enemy, delta):
	# Chờ animation đến thời điểm tung đòn
	if not has_dashed:
		if enemy.animation_player.get_current_animation_position() < 0.5:
			enemy.velocity = Vector2.ZERO
			return
		
		# Dash 1 lần duy nhất
		has_dashed = true
		
		var dir = enemy.get_player().global_position - enemy.global_position
		enemy.velocity = dir.normalized() * (enemy.speed * 8.0)

	# Giảm timer
	timer -= delta

	# Khi hết thời gian attack → quyết định state tiếp theo
	if timer <= 0:
		if enemy.distance_to_player() != null and enemy.distance_to_player() > 20:
			var chase = enemy.get_state(ChaseState)
			if chase:
				enemy.change_state(chase)
