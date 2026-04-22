extends EnemyState
class_name ChaseState

func enter(enemy):
	enemy.play_anim("chase")

func update(enemy, delta):
	var distance_to_player = enemy.distance_to_player()

	if distance_to_player != null and distance_to_player > 20:
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
