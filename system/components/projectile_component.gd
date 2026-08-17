class_name ProjectileComponent extends Component


@export var combat_hitbox: Hitbox

@export var screen_notifier: VisibleOnScreenNotifier2D



var movement_component: MovementComponent




func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	movement_component = entity.get_component(MovementComponent)

	movement_component.move_ended.connect(_on_move_ended)

	combat_hitbox.hit_detected.connect(_on_hit_detected)

	screen_notifier.screen_exited.connect(_on_projectile_exited_screen)




func _on_projectile_exited_screen() -> void:

	entity.queue_free.call_deferred()



func _on_hit_detected(target_entity: EntityNode) -> void:

	if target_entity == entity.source_entity:

		return

	var damage_package = DamagePackage.from_attack_entry(entity.projectile_def.attack_entry)

	target_entity.receive_damage_package(damage_package)

	movement_component.halt()
	


func _on_move_ended() -> void:

	await Game.get_timer(0.1).timeout

	entity.queue_free.call_deferred()

