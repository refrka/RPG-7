class_name AttackConfig extends Resource



enum SourceType {

	WEAPON,

	UNARMED,

}



@export var source_type: SourceType

@export var attack_set: Array[AttackEntry]