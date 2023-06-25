extends "res://interactables/hint_givers/hint_giver.gd"

@onready var interactable: Area2D = $Interactable
var base_cd: float


func _ready() -> void:
	cooldown = $CooldownTimer
	cooldown_progress = $Cooldown
	base_cd = cooldown.wait_time


func _process(_delta: float) -> void:
	if not cooldown.is_stopped():
		cooldown_progress.value = (cooldown.wait_time - cooldown.time_left) / cooldown.wait_time * 100
	else:
		cooldown_progress.value = 0
		cooldown_progress.hide()


func set_cooldown() -> void:
	cooldown.wait_time = (base_cd - player_stats.taste_cd_bonus) * player_stats.get_multiplier(player_stats.touch_cd_multipliers, player_stats.SIGN.NEGATIVE)


func _on_interactable_interacted(player: Area2D) -> void:
	if not player:
		return
	
	var h = get_hint()
	if h:
		set_cooldown()
		cooldown.start()
		cooldown_progress.show()
		interactable.hide_popup()
		interactable.turn_off()
		unlock_hint(h)
	else:
		# TODO give feedback to player (eg. camshake)
		print("nothing left")


func _on_cooldown_timeout() -> void:
		interactable.turn_on()
