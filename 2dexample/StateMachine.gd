extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var rumbleInterval = .1

onready var mouse = get_node("Mouse")
var curEnabledShrine: String
onready var camera = get_node("../ScreenCamera")
onready var particalHolder = get_node("../RainParticles");
onready var speakerHolder = get_node("../Speakers");

var inRumble: bool = false;
var timeLeft:float  = 0;

var rainSoundChosen;
var vibrateStrengthChosen:Vector2;
var colorChosen:Color;
var hasSmelt = false;
var hasTasted= false;




var inMemory: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	enableUINode("hearingUI",false);
	enablePlayer(true);
	mouse.disable()

func _process(delta):
	if(timeLeft>0):
		timeLeft -= delta
	
	if(inRumble&&vibrateStrengthChosen):
		timeLeft = rumbleInterval+.3
		Input.start_joy_vibration(0, vibrateStrengthChosen.x, vibrateStrengthChosen.y, rumbleInterval)

func enableRainShrine(name, requiresMouse):
	print("Entering memory: ",name)
	if(inMemory):
		return;
	enableUINode(name,true);
	enablePlayer(false);
	curEnabledShrine = name;
	if(requiresMouse):
		mouse.enable()

func exitRainShrine():
	print("Exiting memory: ",curEnabledShrine)
	if(curEnabledShrine==""):
		return;
		
	inMemory=false;
	enableUINode(curEnabledShrine,false);
	enablePlayer(true);
	curEnabledShrine = "";
	mouse.disable()

func enableUINode(name, enable, center=true):
	var node = get_node(name);
	node.visible = enable;
	if(center):
		node.position = get_viewport_center();
	node.set_physics_process(enable)
	node.set_process(enable)
	
func enablePlayer(enable):
	var node = get_node("../Player");
	node.set_physics_process(enable)
	node.set_process(enable)
	if(enable):
		node.enable()
	else:
		node.disable();
	
func start_hearing(_id):
	print("starting to hear")
	enableRainShrine("hearingUI",true)
	get_node("hearingUI").start()
	
func stop_hearing(chosen : String):
	rainSoundChosen=load(chosen);
	exitRainShrine(); 
	for child in speakerHolder.get_children():
		if(child is AudioStreamPlayer2D):
			var audio_node = child as AudioStreamPlayer2D
			audio_node.stream = rainSoundChosen
			audio_node.play()
	
func start_vibrating(_id):
	enableRainShrine("VibratingUI",false)
	get_node("VibratingUI").startRumbling()
	
func stop_vibrating(chosen):
	print("starting to feel")
	vibrateStrengthChosen = chosen
	exitRainShrine();

func start_seeing(_id):
	print("starting to see")
	enableRainShrine("SeeingUI",true)
	get_node("SeeingUI").start()
	
func stop_seeing(chosen):
	colorChosen = chosen
	for child in particalHolder.get_children():
		if(child is Particles2D):
			var partMat = child.process_material as ParticlesMaterial
			partMat.color = chosen;
	
	exitRainShrine();

func start_drinking(_id):
	print("starting to drink")
	enableRainShrine("DrinkingUI",true)
	get_node("DrinkingUI").start()
	
func stop_drinking():
	hasTasted = true
	exitRainShrine();
	
func start_smelling(_id):
	print("starting to smell")
	enableRainShrine("sniffingUI",true)
	get_node("sniffingUI").start()
	
func stop_smelling():
	hasSmelt = true
	exitRainShrine();


func get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2

func inRumbleLand(body):
	print("entered rumble land: ",body.name)
	if(body.name == "Player"):
		inRumble = vibrateStrengthChosen!=null;
	
func exitedRumbleLand(body):
	if(body.name == "Player"):
		inRumble = false


func hasFiveSenses()->bool:
	return rainSoundChosen&&vibrateStrengthChosen&&colorChosen&&hasSmelt&&hasTasted
