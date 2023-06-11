extends Node2D

signal onClicked;
export var showClicked: bool =true;
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
	var node = get_node("Area2D/UiPanel")
	if(Input.is_action_just_pressed("ui_accept") && entered):
		print("clicked")
		if(node&&showClicked):
			node.modulate = Color(.5,.5,.5)
		if(!sent):
			print("sending")
			sent=true
			emit_signal("onClicked",id);
	elif(node&&showClicked&&!Input.is_action_pressed("ui_accept")):
		node.modulate = Color(1,1,1)

func selected(vis):
	get_node("Area2D/ColorRect").visible = vis
