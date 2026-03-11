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


func _get_drag_data(pos):
	if slot.is_empty():
		return
	
	var preview = TextureRect.new()
	preview.texture = slot.item.icon
	set_drag_preview(preview)
	
	return self


func _can_drop_data(pos, data):
	return data is Control and data.has_method("update_ui") 


func _drop_data(pos, data):
	var temp_item = slot.item
	var temp_amount = slot.amount
	
	slot.item = data.slot.item
	slot.amount = data.slot.amount
	
	data.slot.item = temp_item
	data.slot.amount = temp_amount
	
	update_ui()
	data.update_ui()
