extends Control

# Scene prefab của slot UI (dùng chung với inventory)
@export var slot_scene : PackedScene
# Container chứa các slot hotbar
@export var container: HBoxContainer
# Số lượng slot trong hotbar
@export var hotbar_size: int = 6

# Mảng chứa các node slot UI của hotbar
var hotbar_slots = []
# Index của slot đang được chọn (highlight)
var selected_slot_index: int = 0

func _ready():
	var inventory_manager = InventoryManager
	
	# Tạo các slot UI cho hotbar, liên kết với các slot đầu tiên của inventory
	for i in hotbar_size:
		var slot = slot_scene.instantiate()
		container.add_child(slot)
		
		# Liên kết với slot thứ i trong inventory (0-5)
		slot.slot = inventory_manager.slots[i]
		hotbar_slots.append(slot)
	
	# Kết nối signal để cập nhật UI khi inventory thay đổi
	inventory_manager.inventory_changed.connect(update_hotbar)
	
	update_hotbar()
	highlight_selected_slot()

# Cập nhật hiển thị tất cả các slot trong hotbar
func update_hotbar():
	for slot in hotbar_slots:
		slot.update_ui()

# Xử lý input cho hotbar (phím số 1-6 để chọn slot)
func _input(event):
	# Phím số 1-6 để chọn slot
	for i in range(hotbar_size):
		if event.is_action_pressed("hotbar_" + str(i + 1)):
			selected_slot_index = i
			highlight_selected_slot()
			use_selected_item()
			break
	
	# Scroll chuột để chuyển slot
	if event.is_action_pressed("hotbar_next"):
		selected_slot_index = (selected_slot_index + 1) % hotbar_size
		highlight_selected_slot()
	elif event.is_action_pressed("hotbar_previous"):
		selected_slot_index = (selected_slot_index - 1 + hotbar_size) % hotbar_size
		highlight_selected_slot()

# Highlight slot đang được chọn
func highlight_selected_slot():
	for i in range(hotbar_slots.size()):
		var slot = hotbar_slots[i]
		var panel = slot.get_node("Panel")
		
		if i == selected_slot_index:
			panel.self_modulate = Color(1.5, 1.5, 0.5) * 4  # Vàng sáng
		else:
			panel.self_modulate = Color(1.0, 1.0, 1.0)  # Bình thường


# Sử dụng item trong slot đang chọn
func use_selected_item():
	var slot = InventoryManager.slots[selected_slot_index]
	
	if slot.is_empty():
		return
	
	# Xử lý sử dụng item dựa trên loại
	match slot.item.type:
		ItemData.ItemType.WEAPON:
			equip_weapon(slot)
		_:
			print("Item này không thể sử dụng từ hotbar")

# Sử dụng vật phẩm tiêu hao
func use_consumable(slot: Slot):
	print("Đã sử dụng: ", slot.item.name)
	# TODO: Thêm logic hồi máu, mana, buff...
	
	# Giảm số lượng
	InventoryManager.remove_item(selected_slot_index, 1)

# Trang bị vũ khí
func equip_weapon(slot: Slot):
	print("Đã trang bị: ", slot.item.name)
	# TODO: Thêm logic trang bị vũ khí cho player
