class_name UIElement extends Control


@warning_ignore_start("unused_signal")

signal close_requested



@export var pause_game:= false

@export var stay_connected:= false

var active:= true

var connected:= false













func _activate() -> void:

	active = true

	show()

	if !connected:

		_connect_signals()




func _deactivate() -> void:

	active = false

	hide()

	if connected and !stay_connected:

		_disconnect_signals()





func _connect_signals() -> void:

	pass




func _disconnect_signals() -> void:

	pass