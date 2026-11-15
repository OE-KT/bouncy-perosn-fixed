extends Area2D

var won = false
var victoryJinggle = load("res://Victory19.wav")
func _on_body_entered(body: Node2D) -> void:
	if(not won):
		won = true
		body.win()
		$StarSprite.visible = false
		$StarParticals.visible = false
		$CollectParticals.restart()
		$Auido.stream = victoryJinggle
		$Auido.play()
	pass # Replace with function body.
func _ready() -> void:
	$StarSprite.play()
