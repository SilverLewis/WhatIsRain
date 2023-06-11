extends Node2D

var buttonList = [];
var CustomButton = preload('onButton.gd')

var audio_node = null
var lastSelected =null;

signal exitMemory

var sounds = []

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_node = $Audio_Stream_Player
	audio_node.connect("finished", self, "test")
	audio_node.stop()
	
	var sound_directory = Directory.new()
	sound_directory .open("res://rainsounds")
	sound_directory.list_dir_begin(true)

	var sound = sound_directory.get_next()
	while sound != "":
		if(!sound.ends_with("import")):
			sounds.append(load("res://rainsounds/" + sound))
		sound = sound_directory.get_next()
	
	var ids = 0
	for child in get_children():
		if(child is CustomButton and child.has_signal("onClicked")):
			child.connect("onClicked",self,"buttonClicked")
		
func buttonClicked(num):
	if(num<sounds.size()):
		lastSelected = sounds[num]
		audio_node.stream = sounds[num]
		audio_node.play()
	else:
		finished();

func finished():
	print("here")
	if(lastSelected != null):
		emit_signal("exitMemory",lastSelected);

func test():
	print("finished");
		
func destroy_self():
	audio_node.stop()
	queue_free()
