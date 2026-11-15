extends AnimatableBody2D
@export var moveAmmount = Vector2(0,0)
@export var button : Node2D
var doorOpen = false
func _ready():
	button.connect("body_entered", openDoor)
	
func openDoor(body: Node2D) -> void:
	if(doorOpen):
		return
	if(button.requireSlam && not body.dived):
		return
	print("Door Open")
	$CollisionShape2D.set_deferred("disabled", true)
	$MeshInstance2D.visible = false
	button.pushedButton()
	doorOpen = true
	pass # Replace with function body.
