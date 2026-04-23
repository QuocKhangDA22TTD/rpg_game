extends CharacterBody2D

@export var data: EnemyData
@export var states: Array[EnemyState]
@export var sprite_2d: Sprite2D
@export var animation_player: AnimationPlayer

var current_state: EnemyState
var hp: int
var speed: float

func _ready():
	hp = data.max_hp
	speed = data.speed
	
	for state in data.states:
		states.append(state)
	
	# GÁN ANIMATION
	if data.animation_library:
		# Kiểm tra nếu animation library đã tồn tại trong animation player, nếu chưa thì thêm vào
		if not animation_player.has_animation_library(""):
			animation_player.add_animation_library("", data.animation_library)

	# bắt đầu state đầu tiên
	if states.size() > 0:
		change_state(states[0])


func _physics_process(delta):
	if current_state:
		current_state.update(self, delta)
	
	# lật sprite dựa trên hướng di chuyển
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0

	move_and_slide()


func change_state(new_state):
	if current_state:
		current_state.exit(self)

	current_state = new_state

	if current_state:
		current_state.enter(self)


func play_anim(name):
	if animation_player.has_animation(name):
		animation_player.play(name)


func get_player():
	return GameManager.player


func get_state(state_type):
	for state in states:
		if is_instance_of(state, state_type):
			return state
	return null


func distance_to_player():
	var player = get_player()
	if player:
		return global_position.distance_to(player.global_position)
	return null


func take_damage(amount, source = null): # source là nguồn gây sát thương, có thể là player hoặc một cái gì đó khác
	hp -= amount
	
	# Kiểm tra nếu hp <= 0 để vào trạng thái chết
	if hp <= 0:
		change_state(get_state(DieState))
		return
	
	var hit_state = get_state(HitState)
	hit_state.damage_source = source # Truyền nguồn gây sát thương vào hit state để có thể sử dụng nếu cần
	change_state(hit_state)
