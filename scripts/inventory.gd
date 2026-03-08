extends Node
class_name Inventory

signal inventory_changed

@export var size : int = 30

var slots : Array = []

func _ready():
	for i in size:
		slots.append(Slot.new())


func add_item(item: ItemData, amount: int = 1):
	# stack trước
	for slot in slots:
		if slot.item == item and slot.amount < item.max_stack:
			var space = item.max_stack - slot.amount
			var add = min(space, amount)
			
			slot.amount += add
			amount -= add
			
			if amount <= 0:
				emit_signal("inventory_changed")
				return true
	
	# slot trống
	for slot in slots:
		if slot.is_empty():
			slot.item = item
			slot.amount = amount
			emit_signal("inventory_changed")
			return true
	
	return false


func remove_item(index:int, amount:int):
	var slot = slots[index]
	slot.amount -= amount
	
	if slot.amount <= 0:
		slot.item = null
		slot.amount = 0
		
	emit_signal("inventory_changed")
