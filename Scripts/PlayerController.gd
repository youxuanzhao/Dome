extends KinematicBody2D

var velocity = Vector2.ZERO

export var MAX_SPEED = 150
export var FRICTION = 100
export var ACCELERATION = 20
export var FACTOR = 1

onready var PlayerSprite = $PlayerSprite
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED * FACTOR , ACCELERATION * FACTOR)
		if input_vector.x > 0:
			PlayerSprite.frame = 0
		elif input_vector.x < 0:
			PlayerSprite.frame = 1
		elif input_vector.y > 0:
			PlayerSprite.frame = 2
		elif input_vector.y < 0:
			PlayerSprite.frame = 3
	else:
		velocity = velocity.move_toward(Vector2.ZERO , FRICTION)
	
	move_and_slide(velocity)
