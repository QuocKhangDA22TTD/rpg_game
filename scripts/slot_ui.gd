extends Control

var slot : Slot

@export var icon: TextureRect
@export var amount: Label

func update_ui():
	if slot == null or slot.is_empty():
		icon.texture = null
		amount.text = ""
		return
	
	icon.texture = slot.item.icon
	
	if slot.amount > 1:
		amount.text = str(slot.amount)
	else:
		amount.text = ""
