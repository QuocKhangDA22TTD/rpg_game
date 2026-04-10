extends EnemyState
class_name IdleState

@export var next_state: EnemyState
@export var wait_time: float = 2.0

var timer := 0.0

func enter(enemy):
    timer = 0
    enemy.play_anim("idle")

func update(enemy, delta):
    timer += delta
    enemy.velocity = Vector2.ZERO

    if timer >= wait_time and next_state:
        enemy.change_state(next_state)