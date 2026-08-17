class_name MovementComponent extends Component




signal move_started

signal move_ended

signal face_dir_updated


var animation_component: AnimationComponent


var move_dir:= Vector2.ZERO

var face_dir:= Vector2.RIGHT

var move_speed_override:= -1.0



var can_move:= true

var can_turn:= true



var current_move_velocity:= Vector2.ZERO

var current_input_velocity:= Vector2.ZERO

var modifiers: Array[VelocityModifier]



func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	animation_component = entity.get_component(AnimationComponent)





func reset() -> void:

	can_move = true

	can_turn = true

	current_move_velocity = Vector2.ZERO

	set_move_dir(Vector2.ZERO)

	set_face_dir(Vector2.RIGHT)




func add_modifier(modifier: VelocityModifier) -> void:

	modifiers.append(modifier)




func halt() -> void:

	entity.velocity = Vector2.ZERO

	current_move_velocity = Vector2.ZERO

	move_dir = Vector2.ZERO

	move_ended.emit()

	animation_component.travel_playback("body", "IdleBlend")




func get_move_speed() -> float:

	if move_speed_override != -1.0:

		return move_speed_override

	var speed = entity.get_entity_def().move_speed

	for modifier in modifiers:

		if modifier.multiplier > 0.0:

			speed *= modifier.multiplier

	return speed








func set_move_dir(dir: Vector2) -> void:

	move_dir = dir



func set_face_dir(dir: Vector2) -> void:

	if dir == face_dir or dir == Vector2.ZERO:

		return

	face_dir = dir

	face_dir_updated.emit()

	animation_component.set_blendspace_vector("moving", face_dir)

	animation_component.set_blendspace_vector("idle", face_dir)

	animation_component.set_blendspace_vector("flinch", face_dir)

	if is_moving():

		animation_component.start_playback("body", "MovingBlend")






func is_moving() -> bool:

	if can_move and move_dir != Vector2.ZERO:

		return true

	return current_move_velocity != Vector2.ZERO









func _get_impulse_velocity() -> Vector2:

	var total = Vector2.ZERO

	for modifier in modifiers:

		if modifier.modifier_type == VelocityModifier.ModifierType.CUMULATIVE:

			total += modifier.velocity

	return total





func _tick_modifiers(delta: float) -> void:

	for i in range(modifiers.size() - 1, -1, -1):

		modifiers[i].tick(delta)

		if modifiers[i].is_expired():

			modifiers.remove_at(i)




func _physics_process(delta: float) -> void:

	if !active:

		return

	_tick_modifiers(delta)

	if can_turn:

		current_input_velocity = move_dir * get_move_speed()

		if move_dir != Vector2.ZERO and move_dir != face_dir:

			set_face_dir(move_dir)

	if can_move:

		if current_move_velocity == Vector2.ZERO and current_input_velocity != Vector2.ZERO:

			move_started.emit()
		
			animation_component.travel_playback("body", "MovingBlend")

		if current_move_velocity != Vector2.ZERO and current_input_velocity == Vector2.ZERO:

			move_ended.emit()
		
			animation_component.travel_playback("body", "IdleBlend")

		entity.velocity = current_input_velocity + _get_impulse_velocity()

		current_move_velocity = entity.velocity

		entity.move_and_slide()