class_name AnimationComponent extends Component



@export var anim_player: AnimationPlayer

@export var anim_tree: AnimationTree



var playback_paths:= {

	"root": "parameters/RootState/playback"

}








func travel_playback(playback_name: String, node_name: String) -> void:

	var playback = _get_playback(playback_name)
	
	if playback:

		playback.travel(node_name)





func _get_playback(playback_name: String) -> AnimationNodeStateMachinePlayback:

	if playback_paths.has(playback_name):

		var path = playback_paths[playback_name]

		return anim_tree.get(path)

	return null

