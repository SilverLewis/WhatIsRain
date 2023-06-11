extends Node2D

signal onClicked;


var entered: bool  = false;
var sent:bool = false
export var id: int = 0;

func _on_Area2D_body_entered(_body):
	print("entered")
	entered = true;
	
func _on_Area2D_body_exited(_body):
	print("exited")
	entered = false;
	sent = false
	
func _process(_delta):
	if(Input.is_action_just_pressed("ui_select") && entered && !sent):
		print("sending")
		sent=true
		emit_signal("onClicked",id);

func _on_Area2D_area_entered(area):
	print("HERE2: ",area)
