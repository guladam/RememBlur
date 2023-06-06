extends CanvasLayer

signal guess_entered(guess: String)

@onready var latest_hint_screen: CenterContainer = $LatestHintScreen
@onready var all_hints_screen: CenterContainer = $AllHintsScreen
@onready var puzzle_letters: Control = $PuzzleLetters
@onready var guesser_ui: CenterContainer = $GuesserUI
@onready var time_left: MarginContainer = $TimeLeft
@onready var health_bar: MarginContainer = $HealthBar


func _ready() -> void:
	latest_hint_screen.switch_to_all_hints_screen.connect(show_all_hints_screen)
	guesser_ui.guess_entered.connect(func(guess: String): guess_entered.emit(guess))


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
