extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mouse = get_node("Mouse")
var curEnabledShrine: String
onready var camera = get_node("../ScreenCamera")

var rainSoundChosen;
var vibrateStrengthChosen;

var inMemory: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	enableUINode("hearingUI",false);
	enableUINode("Player",true,false);
	mouse.disable()

func enableRainShrine(name, requiresMouse):
	print("Entering memory: ",name)
	if(inMemory):
		return;
	enableUINode(name,true);
	enableUINode("Player",false,false);
	curEnabledShrine = name;
	if(requiresMouse):
		mouse.enable()

func exitRainShrine():
	print("Exiting memory: ",curEnabledShrine)
	if(curEnabledShrine==""):
		return;
		
	inMemory=false;
	enableUINode(curEnabledShrine,false);
	enableUINode("Player",true);
	curEnabledShrine = "";
	mouse.disable()

func enableUINode(name, enable, center=true):
	var node = get_node(name);
	node.visible = enable;
	if(center):
		node.position = get_viewport_center();
	node.set_physics_process(enable)
	node.set_process(enable)
	
func start_hearing(_id):
	enableRainShrine("hearingUI",true)
	
func stop_hearing(chosen):
	rainSoundChosen = chosen
	exitRainShrine();
	
func start_vibrating(_id):
	enableRainShrine("VibratingUI",false)
	get_node("VibratingUI").startRumbling()
	
func stop_vibrating(chosen):
	vibrateStrengthChosen = chosen
	exitRainShrine();

func start_seeing(_id):
	enableRainShrine("SeeingUI",true)
	get_node("SeeingUI").start()
	
func stop_seeing(chosen):
	vibrateStrengthChosen = chosen
	exitRainShrine();


func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2

