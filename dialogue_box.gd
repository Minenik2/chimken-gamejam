extends Node2D

@onready var textLabel: Label = $PanelContainer/VBoxContainer/text
@onready var choice_button_scn = preload("res://scene/ChoiceButton.tscn")
@onready var v_box_container: VBoxContainer = $PanelContainer/VBoxContainer
var choice_buttons: Array[Button] = []

func _ready() -> void:
	add_choice("this is choice number 0")
	add_choice("this is choice number 1")

func clear_dialogue_box():
	textLabel.text = ""
	for choice in choice_buttons:
		v_box_container.remove_child(choice)
	choice_buttons = []

func add_text(text: String):
	textLabel.text = text
	
func add_choice(choice_text: String):
	var button_obj: ChoiceButton = choice_button_scn.instantiate()
	button_obj.choice_index = choice_buttons.size()
	choice_buttons.push_back(button_obj)
	button_obj.text = choice_text
	button_obj.choice_selected.connect(_on_choice_selected)
	v_box_container.add_child(button_obj)

func _on_choice_selected(choice_index: int):
	print(choice_index)
	($EzDialogue as EzDialogue).next(choice_index)
