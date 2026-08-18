class_name DebugRoot extends UIElement


@export var combat_state_row: HBoxContainer

@export var default_state_row: HBoxContainer


@export var entity_state_label: Label

@export var default_state_label: Label

@export var combat_state_label: Label

@export var ready_state_label: Label

@export var charge_attack_state_label: Label

@export var execute_attack_state_label: Label

@export var finish_attack_state_label: Label

@export var flinch_state_label: Label

@export var default_idle_state_label: Label

@export var default_moving_state_label: Label

@export var body_idle_state_label: Label

@export var body_moving_state_label: Label

@export var body_flinch_state_label: Label



func _ready() -> void:

	Events.subscribe(GameLoadedEvent, _on_game_loaded)
















func _activate() -> void:

	super()

	_update_player_entity_state()

	_update_player_playback_state()





func _update_player_entity_state() -> void:

	if !Game.is_active():

		return

	entity_state_label.text = Game.player.state_machine.get_current_state().get_state_name()



func _update_player_playback_state() -> void:

	if !active:

		return

	charge_attack_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	combat_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	default_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	ready_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	execute_attack_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	flinch_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	body_idle_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	body_moving_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	body_flinch_state_label.add_theme_color_override("font_color", Color("#6a6a6a"))

	var animation_component = Game.player.get_component(AnimationComponent)

	var current_root_node = animation_component.get_playback_current_node("root")

	match current_root_node:

		"DefaultState":

			default_state_label.remove_theme_color_override("font_color")

		"CombatState":

			combat_state_row.show()

			combat_state_label.remove_theme_color_override("font_color")

			var current_combat_node = animation_component.get_playback_current_node("combat")

			match current_combat_node:

				"CombatReadyBlend":

					ready_state_label.remove_theme_color_override("font_color")

				"ExecuteAttackState":

					execute_attack_state_label.remove_theme_color_override("font_color")

				"FinishAttackState":

					finish_attack_state_label.remove_theme_color_override("font_color")

				"FlinchState":

					flinch_state_label.remove_theme_color_override("font_color")

	var current_body_node = animation_component.get_playback_current_node("body")

	match current_body_node:

		"IdleBlend":

			body_idle_state_label.remove_theme_color_override("font_color")

		"MovingBlend":

			body_moving_state_label.remove_theme_color_override("font_color")

		"FlinchBlend":

			body_flinch_state_label.remove_theme_color_override("font_color")





func _on_game_loaded(_event: Event) -> void:

	var player = Game.get_player()

	player.state_machine.state_changed.connect(_on_player_state_changed)

	var animation_component = player.get_component(AnimationComponent)

	animation_component.playback_state_changed.connect(_on_player_playback_state_changed)





func _on_player_state_changed(_new_state: State) -> void:

	if active:

		_update_player_entity_state()






func _on_player_playback_state_changed(_playback_name: String, _node_name: String) -> void:

	await get_tree().process_frame

	await get_tree().process_frame

	_update_player_playback_state()