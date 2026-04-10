extends CharacterBody2D

@export var speed: float = 50
@export var max_hp: int = 10
@export var damage: int = 1

var hp: int

func _ready():
	hp = max_hp

func _physics_process(delta):
	move_and_slide()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		die()

func die():
	queue_free()
