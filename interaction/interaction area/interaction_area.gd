extends Area2D
class_name InteractionArea

@export var action_name: String = "interact" 

var interact: Callable = func():
	pass
	
var hoversprite: Sprite2D


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)
	if hoversprite:
		hoversprite.frame = 1


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
	if hoversprite:
		hoversprite.frame = 0
