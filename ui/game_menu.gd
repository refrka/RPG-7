class_name GameMenu extends UIElement




@export var resume_button: Button

@export var return_button: Button

@export var quit_button: Button




func _ready() -> void:

	_deactivate()

	resume_button.pressed.connect(_on_resume_pressed)

	return_button.pressed.connect(_on_return_pressed)

	quit_button.pressed.connect(_on_quit_pressed)






func _on_resume_pressed() -> void:

	close_requested.emit()



func _on_return_pressed() -> void:

	Game.exit()



func _on_quit_pressed() -> void:

	Game.quit()