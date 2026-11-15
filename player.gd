extends CharacterBody2D

var perivousVelosity
const SPEED = 1000.0
const JUMP_VELOCITY = -1200.0
const DIVE_SPEED = 2200.0
var currentJumpSpeed = JUMP_VELOCITY
var timeSinceGroundHit = 0
var currentSpeed = SPEED
var dived = false
var dead = false
var bobSpriteAir = load("res://CircleManAir.png")
var bobSpriteAirMoving = load("res://CircleManAirRight.png")
var bobGrounded = load("res://CircleMaGroundedn.png")
var goingDown
var gameReady
var hitGroundNormalSfx : AudioStream = load("res://Hit7 (1).wav")
var slamSfx : AudioStream = load("res://Hit7.wav")
var slamedSfx : AudioStream = load("res://Jump15.wav")
var headHit : AudioStream = load("res://Boom46.wav")

var deadSfx : AudioStream = load("res://Boom50.wav")
var deathSprite = load("res://CirclePersonDead.png")
@export var UI : CanvasLayer
@export var deathPos : Marker2D
@export var respawnOn = false
func _physics_process(delta: float) -> void:
	goingDown = velocity.y < 0
	if(goingDown):
		$Sprite.flip_v = false
	else:
		$Sprite.flip_v = true
	# Add the gravity.
	if(dead):
		return
	timeSinceGroundHit += delta
	if not is_on_floor():
		velocity += (get_gravity() * timeSinceGroundHit) * delta
		timeSinceGroundHit += delta
		$Sprite.texture = bobSpriteAir

	if is_on_ceiling():
		velocity.y = -perivousVelosity.y
		$Auido.stream = headHit
		$Auido.play()
	# Handle jump.
	if is_on_floor():
		$Sprite.flip_v = false
		$Sprite.texture = bobGrounded
		velocity.y = currentJumpSpeed
		if(dived):
			$Auido.stream = slamSfx
			$Auido.play()
		else:
			$Auido.stream = hitGroundNormalSfx
			$Auido.play()
		dived = false
		currentJumpSpeed = JUMP_VELOCITY
		timeSinceGroundHit = 0
		
		
	if(Input.is_action_just_pressed("dive") && not is_on_floor() && not dived):
		$Auido.stream = slamedSfx
		$Auido.play()
		velocity.y = DIVE_SPEED
		dived = true
		currentJumpSpeed = JUMP_VELOCITY * 1.4

			
			
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		$Sprite.rotation = move_toward(0, 0.2 * direction, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Sprite.rotation = move_toward(rotation, 0, SPEED)
	
	perivousVelosity = velocity
	move_and_slide()
	if(position.y > deathPos.position.y && !dead):
		die()
func die():
	if(not dead):
		
		dead = true
		UI.deathScreenActive(true)
		$Auido.stream = deadSfx
		$Auido.play()
		$Sprite.texture = deathSprite
		$Sprite.z_index = 2
func _ready() -> void:
	if(respawnOn):
		position = get_parent().get_node("RespawnPoint").position
func win():
	dead = true
	UI.winScreen()
