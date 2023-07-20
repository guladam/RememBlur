extends Resource
class_name PlayerStats

signal player_died
signal health_changed
signal max_health_changed

enum SIGN { NEGATIVE, POSITIVE }

@export_group("Health")
@export var default_max_health := 3
@export var health := 3:
	set(value):
		health = clampi(value, 0, self.max_health)
		health_changed.emit()
		
		if health <= 0:
			player_died.emit()

@export var max_health := 3:
	set(value):
		var really_changed := max_health != value
		max_health = value
		if really_changed:
			max_health_changed.emit()
			self.health += 1


@export_group("Upgrades")
@export var upgrade_options := 3

@export_group("Movement")
@export var move_speed_bonus := 0
@export var move_speed_multipliers: Array[float]

@export_group("Time Bonuses")
@export var time_bonus := 0
@export var time_multipliers: Array[float]

@export_group("Sense Cooldowns")
@export var universal_cd_bonus := 0
@export var universal_cd_multipliers: Array[float]
@export var sight_cd_bonus := 0
@export var sight_cd_multipliers: Array[float]
@export var hearing_cd_bonus := 0
@export var hearing_cd_multipliers: Array[float]
@export var smell_cd_bonus := 0
@export var smell_cd_multipliers: Array[float]
@export var taste_cd_bonus := 0
@export var taste_cd_multipliers: Array[float]
@export var touch_cd_bonus := 0
@export var touch_cd_multipliers: Array[float]

@export_group("Helpfulness")
@export var helpful_hint_chance := 0.1
@export var helpful_hint_bonus: Array[float]


func get_multiplier(values: Array[float], _sign: SIGN) -> float:
	if values.is_empty():
		return 1.0
		
	var s := 1 if _sign == SIGN.POSITIVE else -1
	return 1.0 + s * values.reduce(func(accum, number): return accum + number)


func reset() -> void:
	max_health = default_max_health
	health = max_health
	upgrade_options = 3
	move_speed_bonus = 0
	time_bonus = 0
	universal_cd_bonus = 0
	sight_cd_bonus = 0
	hearing_cd_bonus = 0
	smell_cd_bonus = 0
	taste_cd_bonus = 0
	touch_cd_bonus = 0
	move_speed_multipliers.clear()
	time_multipliers.clear()
	universal_cd_multipliers.clear()
	sight_cd_multipliers.clear()
	hearing_cd_multipliers.clear()
	smell_cd_multipliers.clear()
	taste_cd_multipliers.clear()
	touch_cd_multipliers.clear()
	helpful_hint_chance = 0.1
	helpful_hint_bonus.clear()
