extends Node2D

export var maxSpeed: float = 8;
var enabled: bool = true;
var xMultiplier: float;


func _ready():
	self.z_index = 1000
	
	enable();

func get_input() -> Dictionary:
	return {
		"x": int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		"y": int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")),
	}
	
func _process(delta):
	xMultiplier = get_viewport_rect().size.x/get_viewport_rect().size.y;
	var vel = Vector2 (get_input()["x"]*xMultiplier, get_input()["y"])
	self.position += vel.normalized() * maxSpeed;
	
	print()

	var size = get_viewport_rect().size;
	var pos = get_global_transform_with_canvas().origin
	
	self.position.x = clamp(self.position.x, 0,size.x);
	self.position.y = clamp(self.position.y, 0,size.y);

func disable():
	enabled= false
	self.visible =enabled
	
func enable():
	enabled = true;
	self.visible =enabled
	self.position = get_viewport_center();
	
func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2
