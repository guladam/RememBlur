extends ColorRect


@onready var new_story: Button = %NewStory
@onready var tutorial: Button = %Tutorial
@onready var options: Button = %Options
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit
@onready var scene_changer: CanvasLayer = $SceneChanger
@onready var main_screen: VBoxContainer = %MainScreen
@onready var options_screen: VBoxContainer = %OptionsScreen
@onready var credits_screen: VBoxContainer = $Screen/CreditsScreen


func _ready() -> void:
	Utils.load_config()
	new_story.pressed.connect(func(): scene_changer.transition_to())
	options.pressed.connect(_show_options_screen)
	credits.pressed.connect(_show_credits_screen)
	tutorial.pressed.connect(func(): scene_changer.transition_to("res://tutorial/tutorial_world.tscn"))
	quit.pressed.connect(func(): get_tree().quit())

	options_screen.back_to_main_menu.connect(_show_main_screen)
	credits_screen.back_to_main_menu.connect(_show_main_screen)

	MusicPlayer.play_song_by_name("lost_in_the_desert.ogg")


func _show_main_screen() -> void:
	main_screen.show()
	options_screen.hide()
	credits_screen.hide()


func _show_options_screen() -> void:
	main_screen.hide()
	options_screen.show()
	credits_screen.hide()


func _show_credits_screen() -> void:
	main_screen.hide()
	options_screen.hide()
	credits_screen.show()
