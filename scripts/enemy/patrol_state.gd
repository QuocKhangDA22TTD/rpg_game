extends EnemyState
class_name PatrolState

@export var speed: float = 40.0
@export var radius: float = 120.0
@export var arrive_threshold: float = 5.0
@export var wait_time: float = 1.5

var origin := Vector2.ZERO
var target := Vector2.ZERO
var wait_timer := 0.0
var is_waiting := false

func enter(enemy):
	origin = enemy.global_position
	_pick_new_target()
	is_waiting = false
	wait_timer = 0.0
	enemy.play_anim("patrol")

func update(enemy, delta):
	var distance_to_player = enemy.distance_to_player()

	# Ưu tiên chase
	if distance_to_player != null and distance_to_player < 100:
		var chase = enemy.get_state(ChaseState)
		if chase:
			enemy.change_state(chase)
			return
	
	if enemy.animation_player.current_animation_position < 0.2:
		enemy.velocity = Vector2.ZERO
		return

	# Nếu đang đứng chờ
	if is_waiting:
		enemy.velocity = Vector2.ZERO
		wait_timer += delta

		if wait_timer >= wait_time:
			is_waiting = false
			_pick_new_target()
			enemy.play_anim("patrol")
		return

	# Di chuyển tới target
	var direction = (target - enemy.global_position).normalized()
	enemy.velocity = direction * speed

	# Đến nơi → đứng chờ
	if enemy.global_position.distance_to(target) <= arrive_threshold:
		is_waiting = true
		wait_timer = 0.0
		enemy.play_anim("idle")

func _pick_new_target():
	target = origin + Vector2(
		randf_range(-radius, radius),
		randf_range(-radius, radius)
	)
