extends CanvasLayer

signal guess_entered(guess: String)

@export var game_state: GameState

@onready var latest_hint_screen: CenterContainer = $LatestHintScreen
@onready var all_hints_screen: PanelContainer = $AllHintsScreen
@onready var puzzle_letters: Control = $PuzzleLetters
@onready var guesser_ui: PanelContainer = $GuesserUI
@onready var time_left: Control = $TimeLeft
@onready var health_bar: MarginContainer = $HealthBar
@onready var guess_btn: Button = $Guess
@onready var hints_btn: Button = $Hints
@onready var helpful_hints: VBoxContainer = $HelpfulHints


func _ready() -> void:
	latest_hint_screen.switch_to_all_hints_screen.connect(show_all_hints_screen)
	guesser_ui.guess_entered.connect(func(guess: String): guess_entered.emit(guess))
	hints_btn.pressed.connect(show_all_hints_screen)
	guess_btn.pressed.connect(show_guesser_ui)


func _unhandled_input(event: InputEvent) -> void:
	if game_state.state != GameState.State.PLAYING:
		return
		
	if event.is_action_pressed("guess"):
		show_guesser_ui()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("hints"):
		show_all_hints_screen()
		get_viewport().set_input_as_handled()


func setup_time_left(timer: Timer) -> void:
	time_left.setup(timer)


func setup_healthbar() -> void:
	health_bar.setup()


func show_latest_hint_screen(hint: Hint) -> void:
	latest_hint_screen.show_screen(hint)


func show_all_hints_screen() -> void:
	all_hints_screen.show_screen()


func show_solution() -> void:
	puzzle_letters.show_solution()


func show_guesser_ui() -> void:
	guesser_ui.show_guesser()


func decrease_helpful_hints() -> void:
	helpful_hints.decrease_number(1)
