extends Resource
class_name ItemData

@export var id : String
@export var name : String
@export var icon : Texture2D
@export var max_stack : int = 99
@export var world_scale : float = 0.0

enum ItemType {
	CONSUMABLE,
	MATERIAL,
	WEAPON,
	ARMOR
	}

@export var type : ItemType
