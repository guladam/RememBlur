extends PanelContainer

signal story_requested

@onready var message: Label = %Message
@onready var story: Button = %Story


func _ready() -> void:
	story.pressed.connect(
		func(): 
			story_requested.emit()
			hide()
	)


func setup(run_name: String, genre: String) -> void:
	message.text = tr("UI_LAST_LEVEL") % [run_name, genre]
