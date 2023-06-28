extends ColorRect


@onready var quit: Button = $Buttons/Quit
@onready var tutorial: Button = $Buttons/Tutorial
@onready var scene_changer: CanvasLayer = $SceneChanger


func _ready() -> void:
	Utils.load_config()
	tutorial.pressed.connect(func(): scene_changer.transition_to("res://tutorial/tutorial_world.tscn"))
	quit.pressed.connect(func(): get_tree().quit())
