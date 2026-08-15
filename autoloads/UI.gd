extends Node




var game_menu: GameMenu

var stack: Array[UIElement]






func _ready() -> void:

	process_mode = Node.PROCESS_MODE_ALWAYS

	game_menu = get_tree().get_first_node_in_group("game_menu")





func clear_stack() -> void:

	for element in stack:

		_remove_element(element)





func _add_to_stack(element: UIElement) -> void:

	stack.append(element)

	_connect_element(element)

	element._activate()

	if element.pause_game and !Game.is_paused():

		Game.pause()




func _remove_element(element: UIElement) -> void:

	stack.erase(element)

	_disconnect_element(element)

	element._deactivate()

	if element.pause_game:

		var paused_elements = stack.duplicate()

		paused_elements.sort_custom(func(e): return e.pause_game)

		if paused_elements.is_empty() and Game.is_paused():

			Game.resume()





func _remove_top_element() -> void:

	var element = stack.back()

	_remove_element(element)




func _connect_element(element: UIElement) -> void:

	element.close_requested.connect(_on_element_close_requested.bind(element))



func _disconnect_element(element: UIElement) -> void:

	element.close_requested.disconnect(_on_element_close_requested)











func _on_element_close_requested(element: UIElement) -> void:

	_remove_element(element)







func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("back"):

		if Game.is_active():

			if stack.is_empty():

				_add_to_stack(game_menu)

			else:

				_remove_top_element()
		else:

			Game.quit()