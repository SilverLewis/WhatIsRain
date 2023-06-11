extends Node2D

export var maxSpeed: float = 8;
export var zoom:= Vector2(.5, .5)

var enabled: bool = true;
var xMultiplier: float;

func _ready():
	self.z_index = 1000

func get_input() -> Dictionary:
	return {
		"x": int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		"y": int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")),
	}
	
func _process(_delta):
	xMultiplier = get_viewport_rect().size.x/get_viewport_rect().size.y;
	var vel = Vector2 (get_input()["x"]*xMultiplier, get_input()["y"])
	self.position += vel.normalized() * maxSpeed;

	var size = get_viewport_rect().size;
	
	var center = get_viewport_center();
	var deltaX = (get_viewport_rect().size.x/2)*zoom.x;
	var deltaY = (get_viewport_rect().size.y/2)*zoom.y;
	
	self.position.x = clamp(self.position.x, center.x-deltaX, center.x+deltaX);
	self.position.y = clamp(self.position.y, center.y-deltaY, center.y+deltaY);
	
func disable():
	enabled= false
	self.visible =enabled
	self.set_process(enabled)
	self.set_physics_process(enabled)
	
func enable():
	enabled = true;
	self.visible = enabled
	self.set_process(enabled)
	self.set_physics_process(enabled)
	self.position = get_viewport_center();

func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2
