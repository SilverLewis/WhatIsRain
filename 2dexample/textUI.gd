extends Node2D

signal theyAreBack;

var active: bool = false;

func start():
	active = true;
	print("active")

func done(id):
	print("here")
	if(active):
		print("done")
		active = false;
		emit_signal("theyAreBack")

