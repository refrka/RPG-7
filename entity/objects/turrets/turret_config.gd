class_name TurretConfig extends Resource



enum TurretMode {

	TARGET,

	FIXED,

	MOVING,

	PROXIMITY,

}


enum TargetMode {

	NONE,

	ANY,

	LIST,

}


@export var turret_mode: TurretMode

@export var target_mode: TargetMode

@export var projectile_def: ProjectileDef

@export var projectile_speed:= 500.0


@export var firing_rate:= 0.0

@export var initial_firing_delay:= 0.0