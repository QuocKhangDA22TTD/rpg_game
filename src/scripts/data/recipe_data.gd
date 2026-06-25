# recipe_data.gd
extends Resource
class_name RecipeData

@export var id: String
@export var name: String
@export var required_ingredients: Array[Ingredient] = []
@export var result_item: ItemData
@export var result_amount: int = 1

# [MỞ RỘNG SAU NÀY]: Bạn có thể thêm các thuộc tính ẩn bên dưới khi game to lên
# @export var required_station: String = "anvil" # Cần đe sắt, bếp lò...
# @export var craft_time: float = 0.0 # Thời gian chế tạo
# @export var gold_cost: int = 0 # Tốn vàng để chế tạo
