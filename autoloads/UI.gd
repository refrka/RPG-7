extends Node




var game_menu: GameMenu

var stack: Array[UIElement]






func _ready() -> void:

	game_menu = get_tree().get_first_node_in_group("game_menu")







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if stack.is_empty():

			stack.append(game_menu)

			game_menu._activate()

		else:

			var top_element = stack.pop_back()

			top_element._deactivate()
