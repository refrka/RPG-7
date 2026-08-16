class_name DamagePackage extends Resource



@export var damage_entries: Array[DamageEntry]








func add_damage_entry(entry: DamageEntry) -> void:

	damage_entries.append(entry)