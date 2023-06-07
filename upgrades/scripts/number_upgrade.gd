@tool
extends "res://upgrades/scripts/upgrade.gd"
class_name NumberUpgrade

@export_enum("Bonus:2", "Multiplier:28") var upgrade_type: int : set = set_upgrade_type
@export var value := 0.0


func _init() -> void:
	type = TYPE_FLOAT


func upgrade(stats: PlayerStats) -> void:
	if type == TYPE_FLOAT or type == TYPE_INT:
		apply(stats, stat_name, value)
	else:
		apply_array(stats, stat_name, value)


func set_upgrade_type(_upgrade_type: int) -> void:
	upgrade_type = _upgrade_type
	type = _upgrade_type as Variant.Type
	property_list_changed.emit()
