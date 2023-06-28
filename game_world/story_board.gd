extends Panel

signal main_menu_requested


@onready var prompt: TextEdit = %Prompt
@onready var main_menu: Button = %MainMenu
@onready var chat_gpt: Button = %ChatGPT


func _ready() -> void:
	main_menu.pressed.connect(func(): main_menu_requested.emit())
	chat_gpt.pressed.connect(func(): OS.shell_open("https://chat.openai.com"))


func show_story(words: Array, genre: String, run_name: String) -> void:
	show()
	var lang := TranslationServer.get_language_name(TranslationServer.get_locale())
	var prompt_text := "Generate a short %s.
Make sure your whole answer is in %s.
Use 150-200 words.
The main character is called %s.
Make sure to include the following words: %s" % [
		genre, lang, run_name, words
	]
	DisplayServer.clipboard_set(prompt_text)
	prompt.text = prompt_text
