class_name IdleState extends State









func _connect_signals() -> void:

	movement_component.move_started.connect(_on_move_started)





func _disconnect_signals() -> void:

	movement_component.move_started.disconnect(_on_move_started)
	





func _update_animation_component() -> void:

	animation_component.set_blendspace_vector("idle", movement_component.face_dir)

	animation_component.travel_playback("root", "DefaultState")

	animation_component.travel_playback("body", "IdleBlend")







func _on_move_started() -> void:

	transition(MovingState)
