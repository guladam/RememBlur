extends Node2D
class_name Level

signal lost
signal won
signal pause

@export var time_limit: float
@export var puzzle: Puzzle
@export var game_state: GameState
@export var player_stats: PlayerStats

@onready var ui: CanvasLayer = $UI
@onready var hint_givers: Node2D = $HintGivers
@onready var guesser: Node = $Guesser
@onready var level_timer: Timer = $LevelTimer


func _ready() -> void:
	puzzle.reset()
	game_state.state = GameState.State.PLAYING
	get_tree().call_group("puzzle_receiver", "setup", puzzle)
	get_tree().call_group("stats_receiver", "set", "player_stats", player_stats)
	
	for hint_giver in hint_givers.get_children():
		hint_giver.show_latest_hint_screen.connect(ui.show_latest_hint_screen)
	
	
	Events.time_bonus_picked_up.connect(add_time)
	guesser.show_guessing_screen.connect(ui.show_guesser_ui)
	guesser.guessed_correctly.connect(ui.show_solution)
	guesser.guessed_correctly.connect(level_won)
	ui.guess_entered.connect(guesser._on_guess_entered)
	
	ui.setup_healthbar()
	
	ui.setup_time_left(level_timer)
	level_timer.wait_time = get_time_with_bonus()
	level_timer.start()
	level_timer.timeout.connect(game_over)
	player_stats.player_died.connect(game_over)

	MusicPlayer.play_song_by_name("game_music.ogg")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause.emit(not get_tree().paused)
		get_viewport().set_input_as_handled()


func get_time_with_bonus() -> float:
	return (time_limit + player_stats.time_bonus) * player_stats.get_multiplier(player_stats.time_multipliers, player_stats.SIGN.POSITIVE)


func game_over() -> void:
	level_timer.stop()
	lost.emit()
	game_state.state = GameState.State.PAUSED


func level_won() -> void:
	level_timer.stop()
	won.emit()
	game_state.state = GameState.State.PAUSED


func add_time(amount: int) -> void:
	level_timer.start(level_timer.time_left + amount)


func set_time(seconds: int) -> void:
	level_timer.start(seconds)
