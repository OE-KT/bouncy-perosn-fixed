extends Area2D
@export var requireSlam = false
var pressedSprite = load("res://ButtonPushed.png")
var bulgedSprite = load("res://ButtonBuldged.png")
var bulgedPressedSprite = load("res://ButtonBuldgedPressed.png")

var bulgedPressSfx = load("res://RubberClicks9 (1).wav")
var normalPressSfx = load("res://RubberClicks9.wav")
func _ready() -> void:
	if(requireSlam):
		$Sprite.texture = bulgedSprite
	pass
func pushedButton():
	if(requireSlam):
		$Auido.stream = bulgedPressSfx 
		$Sprite.texture = bulgedPressedSprite
	else:
		$Sprite.texture = pressedSprite
		$Auido.stream = normalPressSfx 
	$Auido.play()
