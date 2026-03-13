extends Node2D

@export var item : ItemData
@export var amount : int = 1

@onready var sprite = $Sprite2D
@onready var area = $Area2D

func _ready():
	if item and item.icon:
		sprite.texture = item.icon
		
		if item.world_scale > 0:
			sprite.scale = Vector2(item.world_scale, item.world_scale)
		
	area.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player":
		if GameManager.inventory.add_item(item, amount):
			queue_free()
