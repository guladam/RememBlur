extends Resource
class_name Hint

enum Type { TASTE, SMELL, HEARING, TOUCH, SIGHT }

@export var type: Type
@export var text: String
@export var img: Texture
@export var sound: AudioStream


func get_type_as_string() -> String:
	return Type.keys()[type]


func _to_string() -> String:
	return "%s (%s): %s" % [self.resource_name, get_type_as_string(), text]
