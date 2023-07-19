extends Node

const HEARING_HINT_FOLDER := "res://hints/hearing/"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		generate()


func clean_up_tres_files(dir: DirAccess) -> void:
	for file in dir.get_files():
		if file.ends_with(".tres"):
			print("%s deleted" % file)
			dir.remove(file)


func generate() -> void:
	var dir := DirAccess.open(HEARING_HINT_FOLDER)
	if not dir:
		assert(dir, "no such directory")
		return
	
	# delete any previous .tres files
	clean_up_tres_files(dir)
	
	for file in dir.get_files():
		if file.ends_with(".import"):
			continue
			
		var hint_name := file.get_file().trim_suffix(".ogg") + ".tres"
		var h := Hint.new()
		h.type = Hint.Type.HEARING
		h.sound = load(HEARING_HINT_FOLDER + file)
		ResourceSaver.save(h, HEARING_HINT_FOLDER + hint_name)
