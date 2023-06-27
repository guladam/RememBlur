extends ColorRect


@onready var lang_selector: VBoxContainer = $LangSelector
@onready var quit: Button = $Buttons/Quit


func _ready() -> void:
	Utils.load_config()
	lang_selector.setup()
	quit.pressed.connect(func(): get_tree().quit())
