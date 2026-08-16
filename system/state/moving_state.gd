class_name MovingState extends State








func _connect_signals() -> void:

	movement_component.move_ended.connect(_on_move_ended)

	movement_component.face_dir_updated.connect(_on_face_dir_updated)





func _disconnect_signals() -> void:

	movement_component.move_ended.disconnect(_on_move_ended)

	movement_component.face_dir_updated.disconnect(_on_face_dir_updated)
	






func _update_animation_component() -> void:

	animation_component.travel_playback("root", "DefaultState")

	animation_component.travel_playback("body", "MovingBlend")

	_update_facing_dir()




func _update_facing_dir() -> void:

	animation_component.set_blendspace_vector("moving", movement_component.face_dir)




func _on_move_ended() -> void:

	transition(IdleState)



func _on_face_dir_updated() -> void:

	_update_facing_dir()