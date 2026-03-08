extends Resource
class_name Slot

@export var item : ItemData
@export var amount : int = 0

func is_empty():
	return item == null or amount <= 0
