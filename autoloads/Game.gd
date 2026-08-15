extends Node



enum GameState {

	NULL,

	MAIN_MENU,

	ACTIVE,

}


var state: GameState

var last_save_dict:= {}



var player: CharacterNode






func _ready() -> void:

	last_save_dict = load_save()





func start() -> void:

	if last_save_dict.is_empty():

		new_save()

	Scenes.load_location(last_save_dict["saved_location_id"])

	_change_state(GameState.ACTIVE)






func quit() -> void:

	last_save_dict = {}

	Scenes.load_main_menu()

	_change_state(GameState.MAIN_MENU)






func save(_dict:= {}) -> void:

	if _dict.is_empty():

		_dict = _get_game_save_dict()

	var save_file = FileAccess.open("user://save_file.json", FileAccess.WRITE)

	save_file.store_string(JSON.stringify(_dict, " "))

	save_file.close()

	last_save_dict = _dict





func load_save() -> Dictionary:

	if !FileAccess.file_exists("user://save_file.json"):

		return {}

	var json = JSON.new()

	var save_file = FileAccess.open("user://save_file.json", FileAccess.READ)

	json.parse(save_file.get_as_text())
	
	save_file.close()

	return json.data




func new_save() -> void:

	var save_dict = load("res://system/save_template.gd").new().data

	save(save_dict)







func reset() -> void:

	last_save_dict = {}

	if FileAccess.file_exists("user://save_file.json"):

		DirAccess.remove_absolute("user://save_file.json")





func is_active() -> bool:

	return state == GameState.ACTIVE
















func _change_state(new_state: GameState) -> void:

	state = new_state








func _get_game_save_dict() -> Dictionary:

	var save_dict = {}

	return save_dict