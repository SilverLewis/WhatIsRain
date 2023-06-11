extends Node2D


export var startDelay = 2;
export var rumbleLength = .75;
export var delayInBetween = 1;
var currentStrength:=Vector2(.1,0)
var timeLeft = 0;
var RUMBLING = false;

onready var percentLabel: Label = get_node("Strength")

signal vibrateChosen;

func startRumbling():
	RUMBLING = true;
	timeLeft = startDelay;
	percentLabel.text = "0%"
	currentStrength=Vector2(.1,0)

func vibrate():
	print(currentStrength)
	Input.start_joy_vibration(0, currentStrength.x, currentStrength.y, rumbleLength)
	var p:int = ((currentStrength.x+.1)*.35 + (currentStrength.y+.1)*.65)*100
	percentLabel.text = p as String +"%";
	
	if(currentStrength.x<.9):
		currentStrength.x+=.1;
	elif(currentStrength.y<.9):
		currentStrength.y+=.1;
	else:
		currentStrength=Vector2(.1,0)
		
	timeLeft = rumbleLength+delayInBetween;
	
func _process(delta):
	if(RUMBLING):
		if(timeLeft>0):
			timeLeft-=delta
		else:
			vibrate();
			
	if(Input.is_action_just_pressed("ui_accept") &&RUMBLING):
		RUMBLING = false;
		emit_signal("vibrateChosen", currentStrength);
