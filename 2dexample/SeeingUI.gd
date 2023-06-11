extends Node2D

onready var mouse = get_node("../Mouse")
onready var square:ColorRect = get_node("ColorRect")

signal colorChosen;

var seeing: bool = false
export var colorOrder = [Vector3(0,0,1),Vector3(0,1,1),Vector3(1,0,1),Vector3(1,1,1)]
#[Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1),Vector3(1,1,0),Vector3(0,1,1),Vector3(1,0,1),Vector3(1,1,1)]
	
func _process(_delta):
	if seeing:
		var posRelCorner = mouse.position- get_viewport_center()+get_viewport_rect().size/4;
		var color = getColor(posRelCorner)
		square.set_frame_color(color)
	
		if(Input.is_action_just_pressed("ui_accept")):
			emit_signal("colorChosen",color)
			seeing=false
		

func start():
	seeing =true;

func getColor(screenPos) -> Color:
	var size = get_viewport_rect().size/2;
	var amount = colorOrder.size();
	
	#get which segment position is in
	var divider =floor( size.x/amount);
	var pos = floor(screenPos.x/divider)
	var xP = ((floor(screenPos.x)as int % divider as int)/divider)
	
	var xColor ;
	#get color
	if(pos+1>=amount):
		xColor = colorOrder[amount-1]
	else:
		xColor = lerp (colorOrder[pos], colorOrder[pos+1],xP)
	
	var yP = screenPos.y/size.y
	var trueColor = xColor*(1-yP);
	var color =Color(trueColor.x,trueColor.y,trueColor.z,1)
	return color
	
func lerp(v1:Vector3,v2:Vector3,per:float)->Vector3:
	return v1 + (v2 - v1) * per
	
func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2
