extends CanvasLayer

func deathScreenActive(active):
	$UI/Death.visible = active
func winScreen():
	$UI/WinScreen.visible = true
func resetGame():
	get_tree().root.get_node("Node").reset()
func _ready() -> void:
	get_node("UI/Death/Revive").connect("pressed", resetGame)
	get_node("UI/WinScreen/Replay").connect("pressed", resetGame)
