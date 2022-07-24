extends KinematicBody2D

var velocity = Vector2.ZERO
var m_degree = 0.0
var WeaponSpriteX = 0

export var MAX_SPEED = 150
export var FRICTION = 100
export var ACCELERATION = 20
export var FACTOR = 1

onready var PlayerSprite = $PlayerSprite
onready var WeaponSprite = $WeaponSprite
func _ready():
	WeaponSpriteX = WeaponSprite.position.x
func get_movement(velocity):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED * FACTOR , ACCELERATION * FACTOR)
	else:
		velocity = velocity.move_toward(Vector2.ZERO , FRICTION)
	return velocity
func _physics_process(delta):
	m_degree = get_global_mouse_position().angle_to_point(position)
	WeaponSprite.look_at(get_global_mouse_position())
	if m_degree > -1.5 && m_degree < 1.5:
		PlayerSprite.scale.x = 1
		WeaponSprite.scale.y = 1
		WeaponSprite.position.x = WeaponSpriteX
	else:
		PlayerSprite.scale.x = -1
		WeaponSprite.scale.y = -1
		WeaponSprite.position.x = WeaponSpriteX + 18
	velocity = get_movement(velocity)
	move_and_slide(velocity)
