class_name AnimationComponent extends Component



signal playback_state_changed(playback_name: String, node_name: String)



@export var anim_player: AnimationPlayer

@export var anim_tree: AnimationTree



var playback_paths:= {

	"root": "parameters/RootState/playback",

	"body": "parameters/BodyState/playback",

	"combat": "parameters/RootState/CombatState/playback"

}


var blendspace_paths:= {

	"moving": "parameters/BodyState/MovingBlend/blend_position",

	"idle": "parameters/BodyState/IdleBlend/blend_position",

	"flinch": "parameters/BodyState/FlinchBlend/blend_position",

}





func _initialize(_entity: EntityNode) -> void:

	super(_entity)

	reset()





func reset() -> void:

	for path in blendspace_paths.values():

		anim_tree.set(path, Vector2.RIGHT)





func travel_playback(playback_name: String, node_name: String) -> void:

	var playback = _get_playback(playback_name)
	
	if playback and playback.get_current_node() != node_name:

		playback.travel(node_name)

		start_playback(playback_name, node_name)
		
		playback_state_changed.emit(playback_name, node_name)




func start_playback(playback_name: String, node_name: String) -> void:

	var playback = _get_playback(playback_name)

	if !playback:

		return

	playback.start(node_name)




func set_blendspace_vector(blendspace_name: String, vector: Vector2) -> void:

	if blendspace_paths.has(blendspace_name):

		var path = blendspace_paths[blendspace_name]

		anim_tree.set(path, vector)




func get_playback_current_node(playback_name: String) -> String:

	var playback = _get_playback(playback_name)

	return playback.get_current_node()





func get_attack_animation_node() -> AnimationNodeAnimation:

	var tree_root = anim_tree.tree_root

	var root_state = tree_root.get_node("RootState")

	var combat_state = root_state.get_node("CombatState")

	var execute_attack_state = combat_state.get_node("ExecuteAttackState")

	var attack_animation = execute_attack_state.get_node("AttackAnimation")

	return attack_animation



func get_charge_animation_node() -> AnimationNodeAnimation:

	var tree_root = anim_tree.tree_root

	var root_state = tree_root.get_node("RootState")

	var combat_state = root_state.get_node("CombatState")

	var charge_attack_state = combat_state.get_node("ChargeAttackState")

	var charge_animation = charge_attack_state.get_node("ChargeAnimation")

	return charge_animation







func _get_playback(playback_name: String) -> AnimationNodeStateMachinePlayback:

	if playback_paths.has(playback_name):

		var path = playback_paths[playback_name]

		return anim_tree.get(path)

	return null



