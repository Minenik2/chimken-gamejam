extends Resource

class_name Inv

@export var items: Array[InvItem]

func get_item_at(i: int):
	return items[i]
	
func remove_item_at(i: int):
	items[i] = null
	
func check_if_full() -> bool:
	for x in items:
		if x == null:
			return true
	return false
	
func add_item(item: InvItem):
	# Add the item to the first available (null) slot
	for i in range(items.size() - 1):
		if items[i] == null:
			items[i] = item
			print("Added item!")
			print(items)
			return
	print("Inventory is full!")
