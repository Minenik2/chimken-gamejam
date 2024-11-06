extends Label
@onready var shop_manager: Node2D = $"../../../../ShopManager"

func _ready() -> void:
	$".".text = str(shop_manager.money) + " G"

func update():
	$".".text = str(shop_manager.money) + " G"
