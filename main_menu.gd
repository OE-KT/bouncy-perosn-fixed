extends Node2D

var mainGame : PackedScene = load("res://main.tscn")
func _on_start_button_pressed() -> void:
	
	get_tree().change_scene_to_packed(mainGame)
	pass # Replace with function body.
