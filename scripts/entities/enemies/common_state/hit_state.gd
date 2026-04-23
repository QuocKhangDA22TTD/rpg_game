extends EnemyState
class_name HitState

var damage_source = null

func enter(enemy):
	enemy.velocity = Vector2.ZERO
	print("kẻ địch %s bị đánh trúng bởi %s" % [enemy.data.display_name, damage_source])


func update(enemy, delta):
	enemy.play_anim("hit")
	await enemy.animation_player.animation_finished
	enemy.change_state(enemy.get_state(IdleState))
