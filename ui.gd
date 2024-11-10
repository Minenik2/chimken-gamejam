extends CanvasLayer

@export var dialogue_json: JSON
@onready var state = {
	"completed quest": berries_sold > 2
}
var ongoingconversation = false
var berries_sold = 0

func _on_ez_dialogue_dialogue_generated(response: DialogueResponse) -> void:
	$dialogue_box.clear_dialogue_box()
	
	$dialogue_box.add_text(response.text)
	for choice in response.choices:
		$dialogue_box.add_choice(choice)


func _on_ez_dialogue_end_of_dialogue_reached() -> void:
	$"../player".SPEED = 300
	print("end reached")
	ongoingconversation = false


func _on_ez_dialogue_custom_signal_received(value: Variant) -> void:
	var params = value.split(",")
	if params[0] == "buy":
		$ShopManager.buy(params[1])
	elif params[0] == "sell":
		$ShopManager.sell()
		berries_sold += 1
