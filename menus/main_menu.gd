extends ColorRect


@onready var quit: Button = $Buttons/Quit


func _ready() -> void:
	Utils.load_config()
	quit.pressed.connect(func(): get_tree().quit())
