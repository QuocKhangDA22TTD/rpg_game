extends Resource
class_name ItemData

@export var id : String
@export var name : String
@export var icon : Texture2D
@export var max_stack : int = 99

enum ItemType {
	CONSUMABLE,
	MATERIAL,
	WEAPON,
	ARMOR
	}

@export var type : ItemType
