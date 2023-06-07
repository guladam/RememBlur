@tool
extends "res://upgrades/scripts/upgrade.gd"
class_name HealthUpgrade

enum Type { HEAL, FULL_HEAL, MAX_HP }

@export var upgrade_type: Type
@export var value := 0


func _init() -> void:
	type = TYPE_INT


func upgrade(stats: PlayerStats) -> void:
	match type:
		Type.HEAL:
			value = value + stats.health
		Type.FULL_HEAL:
			value = stats.max_health
		Type.MAX_HP:
			value = value + stats.max_health
	apply(stats, stat_name, value)
