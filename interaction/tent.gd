extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var plantbasin: StaticBody2D = $"../plantbasin"

func _ready() -> void:
	interaction_area.interact = Callable(self, "_sleep")
	interaction_area.hoversprite = sprite_2d
	
func _sleep():
	plantbasin.nextDay()
	print("next day!")
