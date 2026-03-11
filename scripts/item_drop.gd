extends Node2D

@export var item : ItemData
@export var amount : int = 1

@onready var sprite = $Sprite2D
@onready var area = $Area2D

func _ready():
	if item and item.icon:
		sprite.texture = item.icon
