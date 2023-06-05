extends "res://interactables/hint_givers/hint_giver.gd"

@onready var interactable: Area2D = $Interactable


func _ready() -> void:
	cooldown = $Cooldown


# TODO do this properly
func _process(_delta: float) -> void:
	if not cooldown.is_stopped():
		$Label.text = str(round(cooldown.time_left))
	else:
		$Label.text = ""


func _on_interactable_interacted(player: Area2D) -> void:
	if not player or not player.has_method("take_box") or not player.has_method("has_box"):
		return
	
	if player.has_box():
		# TODO feedback?
		return
	
	var h = get_hint()
	if h:
		player.take_box(h)
		cooldown.start()
		interactable.hide_popup()
		interactable.turn_off()
	else:
		# TODO give feedback to player (eg. camshake)
		print("nothing left")


func _on_cooldown_timeout() -> void:
		interactable.turn_on()
