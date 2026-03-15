extends Node

var inventory: Inventory
var player: Node

func _ready():
    inventory = Inventory.new()
    inventory.size = 30
    add_child(inventory)

func register_player(player_node: Node):
    player = player_node
