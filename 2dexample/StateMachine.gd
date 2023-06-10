extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mouse = get_node("Mouse")
onready var player2d = get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	enableUINode("Level Node",false);
	mouse.disable()

func _process(_delta):
	if(Input.is_action_pressed("ui_cancel")):
		var node = get_node("Level Node");
		node.position = get_viewport_center();
		node.visible = true;
		mouse.enable()
		
		player2d.set_physics_process(false)
		player2d.set_process(false)
		player2d.visible = false;
	
func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2

func enableUINode(name, enable):
	var node = get_node(name);
	node.position = get_viewport_center();
	node.visible = enable;
	player2d.set_physics_process(enable)
	player2d.set_process(enable)
