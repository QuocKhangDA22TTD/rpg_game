extends ChaseState
class_name SlimeChaseState

func enter(enemy):
	enemy.play_anim("chase")

func update(enemy, delta):
	if enemy.animation_player.current_animation_position < 0.2:
		enemy.velocity = Vector2.ZERO
		return

	var distance_to_player = enemy.distance_to_player()

	if distance_to_player != null and distance_to_player > 30:
		var dir = enemy.get_player().global_position - enemy.global_position
		enemy.velocity = dir.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO

		var attack = enemy.get_state(AttackState)

		if attack:
			enemy.change_state(attack)

	if distance_to_player != null and distance_to_player >= 100:
		var idle = enemy.get_state(IdleState)
		if idle:
			enemy.change_state(idle)
