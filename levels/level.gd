extends Node2D

@export var time_limit: float
@export var puzzle: Puzzle
@export var game_state: GameState
@export var player_stats: PlayerStats

@onready var ui: CanvasLayer = $UI
@onready var hint_examiner: Node2D = $HintExaminer
@onready var guesser: Node2D = $Guesser
@onready var level_timer: Timer = $LevelTimer


func _ready() -> void:
	puzzle.reset()
	game_state.state = GameState.State.PLAYING
	get_tree().call_group("puzzle_receiver", "setup", puzzle)
	get_tree().call_group("stats_receiver", "set", "player_stats", player_stats)
	
	hint_examiner.show_all_hints_screen.connect(ui.show_all_hints_screen)
	hint_examiner.show_latest_hint_screen.connect(ui.show_latest_hint_screen)
	
	guesser.show_guessing_screen.connect(ui.show_guesser_ui)
	guesser.guessed_correctly.connect(ui.show_solution)
	ui.guess_entered.connect(guesser._on_guess_entered)
	
	ui.setup_time_left(level_timer)
	level_timer.wait_time = get_time_with_bonus()
	level_timer.start()
	level_timer.timeout.connect(game_over)
	player_stats.player_died.connect(game_over)


func get_time_with_bonus() -> float:
	return (time_limit + player_stats.time_bonus) * player_stats.get_multiplier(player_stats.time_multipliers, player_stats.SIGN.POSITIVE)


func game_over() -> void:
	print("lost")
