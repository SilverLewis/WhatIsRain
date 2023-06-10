extends Camera2D

# Camera script follwing a target (usually the player)
# This camera is snapped to a grid, therefore only moves when the character exits a screen.

export var target : NodePath
export var align_time : float = 0.2
export var screen_size := Vector2(1920, 1080)

export var move_screen_percentage : float = 30;


onready var Target = get_node_or_null(target)
onready var Twee = $Tween

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(Target):
		var targets: Array = get_tree().get_nodes_in_group("Player")
		if targets: Target = targets[0]
	if not is_instance_valid(Target):
		return
	
	self.global_position = Target.global_position
	
