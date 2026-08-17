class_name MovingState extends State






func _enter() -> void:

	super()








func _connect_signals() -> void:

	movement_component.move_ended.connect(_on_move_ended)





func _disconnect_signals() -> void:

	movement_component.move_ended.disconnect(_on_move_ended)
	







func _on_move_ended() -> void:

	transition(IdleState)

