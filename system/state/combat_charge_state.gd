class_name CombatChargeState extends CombatState


















func _update_animation_component() -> void:

	super()

	animation_component.travel_playback("combat", "ChargeBlend")