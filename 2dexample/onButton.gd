extends Label

signal onClicked;

var entered: bool  = false;
export var id: int = 0;

func _ready():
	print("printing works")
	
func _on_Area2D_body_entered(_body):
	print("entered")
	entered = true;
	
func _on_Area2D_body_exited(_body):
	print("exited")
	entered = false;
	
func _process(_delta):
	if(Input.is_action_just_pressed("ui_select") && entered):
		emit_signal("onClicked",id);

func _on_Area2D_area_entered(area):
	print("HERE2: ",area)