extends EnemyState
class_name HitState

func enter(enemy):
	enemy.velocity = Vector2.ZERO


func update(enemy, delta):
	enemy.play_anim("hit")
	await enemy.animation_player.animation_finished
	enemy.change_state(enemy.get_state(IdleState))
