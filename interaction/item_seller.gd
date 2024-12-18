extends StaticBody2D

@export var dialogue_json: JSON
@export var catgirlShop: JSON
@onready var state = {
	"berries_sold": berries_sold < 9,
	"berries": str(berries_sold)
}

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
var ongoing_conversation = false
var spokenFirstTime = false
var berries_sold = 0

func _ready() -> void:
	interaction_area.interact = Callable(self, "_talk_rasberyl")
	interaction_area.hoversprite = sprite_2d
	
func _talk_rasberyl():
	if !$"../ui".ongoingconversation:
		$"../ui".ongoingconversation = true
		if spokenFirstTime:
			($"../ui/dialogue_box/EzDialogue" as EzDialogue).start_dialogue(catgirlShop, state)
		else:
			($"../ui/dialogue_box/EzDialogue" as EzDialogue).start_dialogue(dialogue_json, state)
			spokenFirstTime = true
		$"../ui/dialogue_box".show()
		$"../player".SPEED = 0
		$AudioStreamPlayer2D.play()
		
func update_state():
	state = {
	"berries_sold": berries_sold < 2,
	"berries": str(berries_sold)
	}
