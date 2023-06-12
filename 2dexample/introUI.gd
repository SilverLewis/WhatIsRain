extends Node2D

export var scene: String = "res://World/TheRealWorld.tscn"

var active: bool = false;

func start():
	active = true;
	print("active")

func done(_id):
	get_tree().change_scene(scene)

