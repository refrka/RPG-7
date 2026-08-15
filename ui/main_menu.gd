class_name MainMenu extends UIElement



signal start_requested

signal reset_requested




@export var start_button: Button

@export var reset_button: Button




func _ready() -> void:

	start_button.pressed.connect(_on_start_pressed)

	reset_button.pressed.connect(_on_reset_pressed)




func _on_start_pressed() -> void:

	start_requested.emit()



func _on_reset_pressed() -> void:

	reset_requested.emit()