extends Sprite

export var clicked: Texture;
export var unclicked: Texture;

var isClicking = false;

func _process(delta):
	if(isClicking !=  Input.is_action_pressed("ui_select") ):
		isClicking = Input.is_action_pressed("ui_select") 
		if(isClicking):
			self.texture = clicked;
		else:
			self.texture = unclicked;

