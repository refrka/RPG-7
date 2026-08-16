class_name MovementComponent extends Component




signal move_started

signal move_ended

signal face_dir_updated


var animation_component: AnimationComponent


var move_dir:= Vector2.ZERO

var face_dir:= Vector2.RIGHT



var can_move:= true

var can_turn:= true



var current_move_velocity:= Vector2.ZERO





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	animation_component = entity.get_component(AnimationComponent)





func reset() -> void:

	can_move = true

	can_turn = true

	current_move_velocity = Vector2.ZERO

	set_move_dir(Vector2.ZERO)

	set_face_dir(Vector2.RIGHT)




func halt() -> void:

	entity.velocity = Vector2.ZERO

	current_move_velocity = Vector2.ZERO

	move_ended.emit()

	animation_component.travel_playback("body", "IdleBlend")




func get_move_speed() -> float:

	return entity.get_entity_def().move_speed








func set_move_dir(dir: Vector2) -> void:

	print("setting dir")

	move_dir = dir



func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir or dir == Vector2.ZERO:

		return

	face_dir = dir

	face_dir_updated.emit()

	animation_component.set_blendspace_vector("moving", face_dir)

	animation_component.set_blendspace_vector("idle", face_dir)






func is_moving() -> bool:

	if can_move and move_dir != Vector2.ZERO:

		return true

	return current_move_velocity != Vector2.ZERO





func _physics_process(_delta: float) -> void:

	if !active:

		return

	var move_velocity = current_move_velocity

	if can_turn:

		move_velocity = move_dir * get_move_speed()

		set_face_dir(move_dir)

	if can_move:

		if current_move_velocity == Vector2.ZERO and move_velocity != Vector2.ZERO:

			move_started.emit()
		
			animation_component.travel_playback("body", "MovingBlend")

		if current_move_velocity != Vector2.ZERO and move_velocity == Vector2.ZERO:

			move_ended.emit()
		
			animation_component.travel_playback("body", "IdleBlend")

		entity.velocity = move_velocity

		current_move_velocity = move_velocity

		entity.move_and_slide()