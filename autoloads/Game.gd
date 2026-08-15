extends Node



enum GameState {

	NULL,

	MAIN_MENU,

	ACTIVE,

}


var state: GameState

var paused:= false

var last_save_dict:= {}



var player: Player






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	last_save_dict = load_save()

	hold_player()





func start() -> void:

	if last_save_dict.is_empty():

		new_save()

	var location = Scenes.load_location(last_save_dict["saved_location_id"])

	var spawn_point_pos = location.get_spawn_point_position(last_save_dict["saved_spawn_id"])

	location.add_entity_node(player, spawn_point_pos)

	_change_state(GameState.ACTIVE)






func exit() -> void:

	last_save_dict = {}

	Scenes.load_main_menu()

	_change_state(GameState.MAIN_MENU)





func quit() -> void:

	get_tree().quit()






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







func pause() -> void:

	get_tree().paused = true

	paused = true




func resume() -> void:

	get_tree().paused = false

	paused = false





func hold_player() -> void:

	get_player()

	if !player.is_inside_tree():

		add_child(player)

	else:

		player.reparent(self)

	player.global_position = Vector2.ZERO

	player._deactivate()

	







func is_active() -> bool:

	return state == GameState.ACTIVE


func is_paused() -> bool:

	return paused









func get_player() -> Player:

	if !player:

		player = load("res://player/player.tscn").instantiate()

		player._initialize()

	return player






func _change_state(new_state: GameState) -> void:

	state = new_state








func _get_game_save_dict() -> Dictionary:

	var save_dict = {}

	return save_dict