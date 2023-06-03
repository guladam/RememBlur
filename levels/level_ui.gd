extends CanvasLayer


@onready var latest_hint_screen: CenterContainer = $LatestHintScreen
@onready var all_hints_screen: CenterContainer = $AllHintsScreen


func show_latest_hint_screen(hint: Hint) -> void:
	latest_hint_screen.show_screen(hint)


func show_all_hints_screen() -> void:
	all_hints_screen.show_screen()
