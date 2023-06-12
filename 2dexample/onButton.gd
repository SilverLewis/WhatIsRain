extends Node2D

signal onClicked;
export var showClicked: bool =true;

onready var node=get_node("Area2D/UiPanel")
onready var timer:Timer=get_node("Timer")
export var spritePath: NodePath
onready var sprite= get_node(spritePath)
var entered: bool  = false;
var sent:bool = false
export var id: int = 0;

func _on_Area2D_body_entered(body):
	if(body.name == "Player"||body.name == "Mouse"):
		print("Entered")
		entered = true;
	
func _on_Area2D_body_exited(body):
	if(body.name == "Player"||body.name == "Mouse"):
		print("exited")
		entered = false;
		sent = false
	
func _process(_delta):
	if(Input.is_action_just_pressed("ui_accept") && entered and visible):
		print("clicked")
		if(node&&showClicked):
			node.modulate = Color(.5,.5,.5)
			if(sprite):
				sprite.modulate = Color(.5,.5,.5)
		if(!sent):
			print("sending ", name)
			sent=true
			timer.one_shot=true
			timer.start()
	elif(node&&showClicked&&!Input.is_action_pressed("ui_accept")):
		node.modulate = Color(1,1,1)
		if(sprite):
			sprite.modulate = Color(1,1,1)
func delayedSend():
	print("delayed send");
	emit_signal("onClicked",id);
func selected(vis):
	get_node("Area2D/ColorRect").visible = vis
