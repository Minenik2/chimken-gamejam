extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var voidplant: Sprite2D = $voidplant
var planted = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_interact")
	interaction_area.hoversprite = sprite_2d
	
func _interact():
	if (Hotbar.return_selected_slot() != null):
		if !planted && Hotbar.return_selected_slot().name == "voidbean":
			planted = true
			plant()
			Hotbar.delete_selected_slot()

func plant():
	voidplant.show()
