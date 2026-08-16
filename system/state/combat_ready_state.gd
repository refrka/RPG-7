class_name CombatReadyState extends CombatState



var ready_timer:= 0.0










func _enter() -> void:

	super()

	ready_timer = 1.5




func _exit() -> void:

	super()

	ready_timer = 0.0





func _update_animation_component() -> void:

	super()

	animation_component.travel_playback("combat", "CombatReadyState")






func _tick(delta: float) -> void:

	if ready_timer > 0.0:

		ready_timer -= delta

		if ready_timer <= 0.0:

			if movement_component.is_moving():

				transition(MovingState)

			else:

				transition(IdleState)