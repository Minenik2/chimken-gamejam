extends Area2D

# Name of the item (e.g., "Health Potion")
@export var item_name: String
@export var quantity: int = 1

# Signal to notify the player to add the item to the inventory
signal picked_up(item_name: String, quantity: int)

func _ready():
	# Enable monitoring for area detection
	set_monitoring(true)

# Called when another body enters this item's area
func _on_Area2D_body_entered(body):
	print("hello")
	print(body)
	if body.name == "angel":  # Ensure it's the player entering
		print("hello")
		emit_signal("picked_up", item_name, quantity)
		queue_free()  # Remove the item from the scene
