extends "res://interactables/action.gd"


func execute() -> void:
	print("remove touchy touchy from pool")


func _on_interactable_interacted(player: Area2D) -> void:
	if player and player.has_method("request_box"):
		player.request_box(Hint.Type.TOUCH)
	execute()
