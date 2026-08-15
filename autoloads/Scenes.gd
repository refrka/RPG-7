extends Node




var main_menu: MainMenu

var world_root: WorldRoot




func _ready() -> void:

	main_menu = get_tree().get_first_node_in_group("main_menu")

	main_menu.start_requested.connect(_on_start_requested)

	main_menu.reset_requested.connect(_on_reset_requested)

	world_root = get_tree().get_first_node_in_group("world_root")







func load_main_menu() -> MainMenu:

	main_menu._activate()

	return main_menu










func load_saved_location() -> Location:

	return null







func load_location(location_id: StringName) -> Location:

	main_menu._deactivate()

	var location = get_location_scene(location_id)

	world_root.load_location(location)

	return location





func unload_location() -> void:

	pass


















func get_active_location() -> Location:

	return world_root.get_active_location()





func get_location_scene(location_id: StringName) -> Location:

	var path = "res://location/%s.scn" % location_id

	if !FileAccess.file_exists(path):

		return null

	return load(path).instantiate()















func _on_start_requested() -> void:

	Game.start()



func _on_reset_requested() -> void:

	Game.reset()