extends Control

@export var inventory: Inv  # Reference to the player's inventory
@export var max_slots := 10  # Number of hotbar slots
@onready var hotbar_sound: AudioStreamPlayer2D = $hotbarSound
@onready var pickup_sound: AudioStreamPlayer2D = $pickupSound

var selected_slot := 0  # Index of the selected slot

func _ready():
	highlight_slot(selected_slot)
	update_hotbar()

func update_hotbar():
	# Update each slot with an item from the inventory
	for i in range(max_slots - 1):
		var slot_button = $MarginContainer/HBoxContainer.get_child(i) as PanelContainer
		slot_button = slot_button.get_child(2) as VBoxContainer
		slot_button = slot_button.get_child(0) as TextureButton
		var item = inventory.get_item_at(i)
		
		# Update the slot's icon based on the inventory item
		if item != null:
			slot_button.texture_normal = item.texture  # Assuming `item.texture` is a texture
		else: 
			slot_button.texture_normal = null # Clear the slot if there's no item

func select_slot(slot_index: int):
	hotbar_sound.play()
	selected_slot = slot_index
	highlight_slot(slot_index)

func highlight_slot(slot_index: int):
	# Add a visual highlight to indicate the selected slot
	for i in range(max_slots - 1):
		var slot_button = $MarginContainer/HBoxContainer.get_child(i) as PanelContainer
		slot_button = slot_button.get_child(2) as VBoxContainer
		slot_button = slot_button.get_child(0) as TextureButton
		slot_button.modulate = Color(1, 1, 1, 1)  # Reset color
		if i == slot_index:
			slot_button.modulate = Color(0.8, 0.8, 1)  # Highlight color

# Input event to handle hotbar switching
func _process(delta):
	for i in range(1, max_slots + 1):
		if Input.is_action_just_pressed("hotbar_slot_" + str(i)):
			select_slot(i - 1)
			
func add_item(item: InvItem):
	pickup_sound.play()
	inventory.add_item(item)
	update_hotbar()

func check_if_full():
	return inventory.check_if_full()
	
func return_selected_slot() -> InvItem:
	return inventory.items[selected_slot]
	
func delete_selected_slot():
	print("slot deleted")
	print(inventory.items[selected_slot])
	inventory.remove_item_at(selected_slot)
	print(inventory.items)
	update_hotbar()
