class_name TurretConfig extends Resource



enum TurretMode {

	TARGET,

	FIXED,

	MOVING,

}


enum TargetMode {

	NONE,

	ANY,

	LIST,

}


var turret_mode: TurretMode

var target_mode: TargetMode


