extends Resource
class_name GameState

@export var state: State:
	set(value):
		state = value
		emit_changed()

enum State { PLAYING, IN_UI, PAUSED }
