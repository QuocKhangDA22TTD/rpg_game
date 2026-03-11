extends Node

var inventory: Inventory

func _ready():
	inventory = Inventory.new()
	inventory.size = 30
	add_child(inventory)
