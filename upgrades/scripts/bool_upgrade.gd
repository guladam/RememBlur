@tool
extends "res://upgrades/scripts/upgrade.gd"
class_name BoolUpgrade


@export var value := true


func _init() -> void:
	type = TYPE_BOOL


func upgrade(stats: PlayerStats) -> void:
	apply(stats, stat_name, value)
