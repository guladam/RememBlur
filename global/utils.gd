extends RefCounted
class_name Utils


static func seconds_to_mm_ss(time: float) -> String:
	var minutes := time / 60.0
	var seconds := fmod(time, 60.0) 
	return "%02d:%02d" % [minutes, seconds]
