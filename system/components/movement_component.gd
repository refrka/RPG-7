class_name MovementComponent extends Component










var move_dir:= Vector2.ZERO



var can_move:= true

var can_turn:= true



var current_move_velocity:= Vector2.ZERO











func get_move_speed() -> float:

	return 200.0








func set_move_dir(dir: Vector2) -> void:

	move_dir = dir








func _physics_process(delta: float) -> void:

	if !active:

		return

	var move_velocity = current_move_velocity


	if can_turn:

		move_velocity = move_dir * get_move_speed()


	if can_move:

		entity.velocity = move_velocity

		entity.move_and_slide()