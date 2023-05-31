extends Resource
class_name Sense

enum Type { TASTE, SMELL, HEARING, TOUCH, SIGHT }

@export var type: Type
@export var text: String
@export var img: Texture
@export var sound: AudioStream
