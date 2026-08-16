class_name InputComponent extends Component



signal weapon_attack_pressed

signal weapon_attack_released


var movement_component: MovementComponent


var move_dir: Vector2






func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)








func _unhandled_input(event: InputEvent) -> void:

	if !active:

		return

	if event.is_action_pressed("weapon_attack"):

		weapon_attack_pressed.emit()

	if event.is_action_released("weapon_attack"):

		weapon_attack_released.emit()







func _process(_delta: float) -> void:

	if !active:

		return

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_dir != move_dir:

		move_dir = input_dir

		movement_component.set_move_dir(move_dir)