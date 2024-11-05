extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var voidplant: Sprite2D = $voidplant
@onready var hotbar: PanelContainer = $"../ui/Hotbar"
@onready var plantsound: AudioStreamPlayer2D = $AudioStreamPlayer2D
var planted = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_interact")
	interaction_area.hoversprite = sprite_2d
	
func _interact():
	if (hotbar.return_selected_slot() != null):
		if !planted && hotbar.return_selected_slot().name == "voidbean":
			plantsound.play()
			planted = true
			plant()
			hotbar.delete_selected_slot()

func plant():
	voidplant.show()
