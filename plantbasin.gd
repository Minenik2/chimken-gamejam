extends StaticBody2D

@export var voidberry: InvItem
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var voidplant: Sprite2D = $voidplant
@onready var hotbar: PanelContainer = $"../ui/Hotbar"
@onready var plantsound: AudioStreamPlayer2D = $AudioStreamPlayer2D
var planted = false
var finished = false

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
			return
	elif finished:
		if hotbar.check_if_full():
			plantsound.play()
			hotbar.add_item(voidberry)
			planted = false
			finished = false
			voidplant.hide()
			voidplant.frame = 0
		else:
			print("could not collect inventory full")

func plant():
	voidplant.show()
	
func nextDay():
	if !finished:
		voidplant.frame += 1
		# if the voidplant has fully grown
		if voidplant.frame == 2:
			finished = true
