extends Node2D


@onready var scene_changer: CanvasLayer = $SceneChanger
@onready var game_over: PanelContainer = $UI/GameOver
@onready var level_won: PanelContainer = $UI/LevelWon
@onready var tutorial_level: Node2D = $CurrentLevel/TutorialLevel


func _ready() -> void:
	game_over.tutorial_message_button_clicked.connect(scene_changer.transition_to)
	level_won.tutorial_message_button_clicked.connect(scene_changer.transition_to)

	tutorial_level.lost.connect(game_over.show_message)
	tutorial_level.won.connect(level_won.show_message)
