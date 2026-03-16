# Script quản lý toàn cục của game (Singleton/Autoload)
extends Node

# Instance kho đồ toàn cục
var inventory: Inventory

# Khởi tạo các hệ thống game
func _ready():
	# Tạo inventory với 30 slot
	inventory = Inventory.new()
	inventory.size = 30
	add_child(inventory)
