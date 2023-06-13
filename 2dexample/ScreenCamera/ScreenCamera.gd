extends Camera2D

# Camera script follwing a target (usually the player)
# This camera is snapped to a grid, therefore only moves when the character exits a screen.

export var target : NodePath
export var align_time : float = 0.2
onready var screen_size = Vector2(ProjectSettings.get_setting("display/window/size/width"),ProjectSettings.get_setting("display/window/size/height"))

export var bufferX:= Vector2(.2, .2)
export var bufferY:= Vector2(.1, .34)

export var move_screen_percentage : float = 30;


onready var Target = get_node_or_null(target)

func _physics_process(_delta: float) -> void:
	if not is_instance_valid(Target):
		var targets: Array = get_tree().get_nodes_in_group("Player")
		if targets: Target = targets[0]
	if not is_instance_valid(Target):
		return
	
	var center = get_viewport_center();
	
	var deltaX = (get_viewport_rect().size.x/2)*zoom.x;
	var deltaY = (get_viewport_rect().size.y/2)*zoom.y;
	
	var xB = Vector2(center.x-deltaX*bufferX.x,center.x+deltaX*bufferX.y)
	var yB = Vector2(center.y-deltaY*bufferY.x, center.y+deltaY*bufferY.y)
	
	if(Target.global_position.x>xB.y):
		self.global_position.x+= Target.global_position.x-xB.y;
	if(Target.global_position.x<xB.x):
		self.global_position.x+= Target.global_position.x-xB.x;
	if(Target.global_position.y>yB.y):
		self.global_position.y+= Target.global_position.y-yB.y;
	if(Target.global_position.y<yB.x):
		self.global_position.y+= Target.global_position.y-yB.x;
		
	

func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2
