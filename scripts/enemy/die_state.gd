extends EnemyState
class_name DieState


func enter(enemy):
	enemy.velocity = Vector2.ZERO


func update(enemy, delta):
	enemy.play_anim("die")
	await enemy.animation_player.animation_finished
	enemy.queue_free()
	return
