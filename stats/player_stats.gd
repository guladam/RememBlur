extends Resource
class_name PlayerStats

signal player_died
signal health_changed
signal max_health_changed

enum SIGN { NEGATIVE, POSITIVE }

@export_group("Health")
@export var health := 3:
	set(value):
		if health != value:
			health_changed.emit()
		
		health = value
		
		if health <= 0:
			player_died.emit()
		
@export var max_health := 3:
	set(value):
		if max_health != value:
			max_health_changed.emit()
			self.health += 1
		max_health = value

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

@export_group("Unlockables")
@export var blood_donation := false


func get_multiplier(values: Array[float], _sign: SIGN) -> float:
	if values.is_empty():
		return 1.0
		
	var s := 1 if _sign == SIGN.POSITIVE else -1
	return 1.0 + s * values.reduce(func(accum, number): return accum + number)
