extends Node
var mainScene = load("res://main.tscn")
func reset():
	
	
	get_tree().change_scene_to_packed(mainScene)
	
