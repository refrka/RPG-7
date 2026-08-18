class_name WorldRoot extends Node2D




var active_location: Location












func load_location(location: Location) -> void:

	if active_location:

		return

	active_location = location

	add_child(location)

	location._initialize()





func get_active_location() -> Location:

	return active_location