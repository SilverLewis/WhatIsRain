extends Sprite

export var clicked: Texture;
export var unclicked: Texture;
onready var audio = get_node("click")
var isClicking = false;

func _process(_delta):
	if(get_parent().visible):
		if(isClicking !=  Input.is_action_pressed("ui_accept") ):
			isClicking = Input.is_action_pressed("ui_accept") 
		if(isClicking):
			self.texture = clicked;
			print("clicked")
			audio.play()
		else:
			self.texture = unclicked;

