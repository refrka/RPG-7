class_name ObjectNode extends EntityNode







func _activate() -> void:

	super()

	if get_display_name() == &"Turret tower":

		print("Activating tower")

		print("player position: ", Game.player.global_position)