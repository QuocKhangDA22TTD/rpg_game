# crafting_manager.gd
extends Node

# Signal phát ra khi chế tạo thành công món đồ nào đó
signal item_crafted(recipe: RecipeData)

# 1. Kiểm tra xem Inventory có đủ nguyên liệu của một công thức không
func has_ingredients(recipe: RecipeData) -> bool:
	for ingredient in recipe.required_ingredients:
		var count = get_item_count_in_inventory(ingredient.item)
		if count < ingredient.amount:
			return false
	return true

# Helper: Đếm tổng số lượng của một loại item đang có trong kho đồ
func get_item_count_in_inventory(target_item: ItemData) -> int:
	var total = 0
	# Gọi trực tiếp qua Autoload InventoryManager của bạn
	for slot in InventoryManager.slots:
		if not slot.is_empty() and slot.item == target_item:
			total += slot.amount
	return total

# 2. Khấu trừ (xóa) nguyên liệu khỏi kho đồ
func consume_ingredients(recipe: RecipeData):
	for ingredient in recipe.required_ingredients:
		var amount_to_remove = ingredient.amount
		
		for slot in InventoryManager.slots:
			if not slot.is_empty() and slot.item == ingredient.item:
				if slot.amount >= amount_to_remove:
					slot.amount -= amount_to_remove
					amount_to_remove = 0
				else:
					amount_to_remove -= slot.amount
					slot.amount = 0
				
				if slot.amount <= 0:
					slot.item = null
				
				if amount_to_remove <= 0:
					break
					
	# Thông báo cho Inventory cập nhật lại giao diện kho đồ
	InventoryManager.emit_signal("inventory_changed")

# 3. Hàm xử lý Chế tạo chính
func craft_item(recipe: RecipeData) -> bool:
	if not has_ingredients(recipe):
		print("CraftingManager: Không đủ nguyên liệu!")
		return false
		
	# Gọi hàm kiểm tra sức chứa có sẵn trong InventoryManager của bạn
	if not InventoryManager.has_space_for(recipe.result_item, recipe.result_amount):
		print("CraftingManager: Kho đồ không đủ chỗ chứa sản phẩm!")
		return false
		
	# Thực hiện trừ đồ cũ và thêm đồ mới
	consume_ingredients(recipe)
	InventoryManager.add_item(recipe.result_item, recipe.result_amount)
	
	# Phát signal thông báo chế tạo thành công (để làm hiệu ứng, tiếng động...)
	emit_signal("item_crafted", recipe)
	return true
