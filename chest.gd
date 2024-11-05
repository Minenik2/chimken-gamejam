extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.interact = Callable(self, "_open_chest")
	
func _open_chest():
	print("open!")
