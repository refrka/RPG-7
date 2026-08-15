class_name Location extends Node2D



@export var nav_region: NavigationRegion2D

@export var tile_map: TileMapLayer

@export var character_root: Node2D

@export var object_root: Node2D

@export var spawn_point_root: Node2D




var active:= false










func _initialize() -> void:

	for character_node in get_all_character_nodes():

		character_node._initialize()







func _populate() -> void:

	pass




	




func add_entity_node(entity_node: EntityNode, target_pos: Vector2) -> void:

	if entity_node.get_parent() != null:

		entity_node.get_parent().remove_child(entity_node)

	_add_entity_to_root(entity_node)

	entity_node.global_position = target_pos

	if active:

		entity_node._activate()

	else:

		entity_node._deactivate()







func get_spawn_point(spawn_id: StringName) -> SpawnPoint:

	for spawn_point in spawn_point_root.get_children():

		if spawn_point.spawn_id == spawn_id:

			return spawn_point

	return null



func get_spawn_point_position(spawn_id: StringName) -> Vector2:

	var spawn_point_position:= Vector2.ZERO

	var spawn_point = get_spawn_point(spawn_id)

	if spawn_point:

		spawn_point_position = spawn_point.global_position

	return spawn_point_position




func get_all_character_nodes() -> Array[CharacterNode]:

	var all_characters: Array[CharacterNode] = []

	all_characters.assign(character_root.get_children())

	return all_characters



func get_all_object_nodes() -> Array[ObjectNode]:

	var all_objects: Array[ObjectNode] = []

	all_objects.assign(object_root.get_children())

	return all_objects




func get_all_entity_nodes() -> Array[EntityNode]:

	return get_all_character_nodes() + get_all_object_nodes()











func _add_entity_to_root(entity_node: EntityNode) -> void:

	var root: Node2D = null

	if entity_node is CharacterNode:

		root = character_root

	elif entity_node is ObjectNode:

		root = object_root

	root.add_child(entity_node)










	



func _activate() -> void:

	active = true

	for entity_node in get_all_entity_nodes():

		entity_node._activate()






func _deactivate() -> void:

	active = false

	for entity_node in get_all_entity_nodes():

		entity_node._deactivate()
