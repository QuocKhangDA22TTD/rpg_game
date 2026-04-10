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
	
	# GÁN ANIMATION
	if data.animation_library:
		animation_player.add_animation_library("default", data.animation_library)
		
	play_anim("idle")

	# bắt đầu state đầu tiên
	if states.size() > 0:
		change_state(states[0])


func _physics_process(delta):
	if current_state:
		current_state.update(self, delta)

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
	return get_tree().get_first_node_in_group("player")
