extends Node2D

@onready var gold_show: Label = $"../HBoxContainer/PanelContainer/MarginContainer/goldShow"

@export var VOIDBEAN: InvItem
@export var VOIDBERRY: InvItem
var money: int = 5

func buy(seed: String):
	if seed == "voidbean":
		money -= 1
		$"../Hotbar".add_item(VOIDBEAN)
		gold_show.update()

func sell():
	if $"../Hotbar".return_selected_slot():
		if $"../Hotbar".return_selected_slot().name == "voidberry":
			print("sold voidberry")
			money += 5
			$"../Hotbar".delete_selected_slot()
			gold_show.update()
			$AudioStreamPlayer2D.play()
