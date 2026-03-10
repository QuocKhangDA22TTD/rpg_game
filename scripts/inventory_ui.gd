extends Control

@export var inventory : Inventory
@export var slot_scene : PackedScene

@export var grid: GridContainer

var slot_nodes = []

func _ready():
	for i in inventory.size:
		var slot = slot_scene.instantiate()
		grid.add_child(slot)
	
		slot.slot = inventory.slots[i]
		slot_nodes.append(slot)
		
	inventory.inventory_changed.connect(update_inventory)
	
	update_inventory()
	
	hide()


func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		visible = !visible


func update_inventory():
	for slot in slot_nodes:
		slot.update_ui()
