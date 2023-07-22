extends PanelContainer

signal upgrade_selected


@export var player_stats: PlayerStats
@export var all_upgrades: Array[Resource]
@onready var upgrades: HBoxContainer = %Upgrades
@onready var upgrade_card := preload("res://upgrades/ui/upgrade_card.tscn")


func show_upgrades() -> void:
	all_upgrades.shuffle()
	
	for c in upgrades.get_children():
		c.queue_free()
	
	for i in range(player_stats.upgrade_options + player_stats.upgrade_options_bonus):
		var new_upgrade_card = upgrade_card.instantiate()
		new_upgrade_card.upgrade = all_upgrades[i]
		upgrades.add_child(new_upgrade_card)
		new_upgrade_card.upgrade_selected.connect(_on_upgrade_selected)
	show()


func _on_upgrade_selected(upgrade: Upgrade) -> void:
	upgrade.upgrade(player_stats)
	upgrade_selected.emit()
	if upgrade.one_time:
		all_upgrades.erase(upgrade)
	hide()
