extends Area2D

# Name of the item (e.g., "Health Potion")
@export var item_name: String
@export var quantity: int = 1
@export var InvItem: InvItem
@onready var hotbar: PanelContainer = $"../ui/Hotbar"

# Signal to notify the player to add the item to the inventory
signal picked_up(item_name: String, quantity: int)

func _ready():
	# Enable monitoring for area detection
	set_monitoring(true)

func _on_body_entered(body: Node2D) -> void:
	print(hotbar.check_if_full())
	if body.name == "player" && hotbar.check_if_full():  # Ensure it's the player entering
		print("picked up", InvItem.name)
		hotbar.add_item(InvItem)
		queue_free()  # Remove the item from the scene
