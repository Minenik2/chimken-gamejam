extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var staminabar: ProgressBar = $"../ui/staminabar"

# Store the last facing direction
var last_facing_left = false

var stamina = 10

func _on_add_stamina_pressed():
	stamina += 1
	staminabar.value = stamina

func _on_subtract_stamina_pressed():
	stamina -= 1
	staminabar.value = stamina

func _physics_process(delta: float) -> void:
	# Animation
	if abs(velocity.x) > 1:
		sprite_2d.animation = "walking"
	else:
		sprite_2d.animation = "default"

	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle movement/deceleration
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		# Update last facing direction
		last_facing_left = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply last facing direction when stopped
	sprite_2d.flip_h = last_facing_left

	# Move the character
	move_and_slide()


## INVENTORY SYSTEM
# Define a dictionary to store item names and quantities
var items = {}

# Maximum number of items in the inventory (optional)
var max_items = 10

# Add an item to the inventory
func add_item(item_name: String, quantity: int = 1):
	if items.has(item_name):
		items[item_name] += quantity
	else:
		if items.size() < max_items:
			items[item_name] = quantity
		else:
			print("Inventory is full")

# Remove an item from the inventory
func remove_item(item_name: String, quantity: int = 1):
	if items.has(item_name):
		items[item_name] -= quantity
		if items[item_name] <= 0:
			items.erase(item_name)

# Check if an item is in the inventory
func has_item(item_name: String) -> bool:
	return items.has(item_name)
	

# Inside the inventory script or a separate InventoryUI script

@onready var inventory_list: VBoxContainer = $"../InventoryUI/inventorybloks"

func update_inventory_display():
	# Clear current UI elements
	inventory_list.clear_children()

	# Add each item as a label
	for item in items:
		var item_label = Label.new()
		item_label.text = item + ": " + str(items[item])
		inventory_list.add_child(item_label)

# Reference to the player's inventory
@export var inventory: Node

func _ready():
	staminabar.value = stamina
	# Connect the signal for each item instance in the scene dynamically
	for item in get_tree().get_nodes_in_group("pickup_items"):
		item.connect("picked_up", Callable(self, "_on_item_picked_up"))

func _on_item_picked_up(item_name: String, quantity: int):
	inventory.add_item(item_name, quantity)
	inventory.update_inventory_display()
