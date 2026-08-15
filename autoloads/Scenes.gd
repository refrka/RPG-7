extends Node




var main_menu: MainMenu

var world_root: Node2D




func _ready() -> void:

	main_menu = get_tree().get_first_node_in_group("main_menu")

	main_menu.start_requested.connect(_on_start_requested)

	main_menu.reset_requested.connect(_on_reset_requested)

	world_root = get_tree().get_first_node_in_group("world_root")







func load_main_menu() -> void:

	main_menu._activate()












func _on_start_requested() -> void:

	Game.start()



func _on_reset_requested() -> void:

	Game.reset()