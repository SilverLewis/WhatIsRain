extends Sprite

export var clicked: Texture;
export var unclicked: Texture;

var isClicking = false;

func _process(_delta):
	if(isClicking !=  Input.is_action_pressed("ui_accept") ):
		isClicking = Input.is_action_pressed("ui_accept") 
		if(isClicking):
			self.texture = clicked;
		else:
			self.texture = unclicked;

