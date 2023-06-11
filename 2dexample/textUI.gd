extends Node2D

signal theyAreBack;

var sniffing: bool = false;

func start():
	sniffing = true;

func _process(delta):
	if(sniffing&&Input.is_action_just_pressed("ui_accept")):
		sniffing = false;
		emit_signal("theyAreBack")
