extends KinematicBody2D

var velocity = Vector2.ZERO
var m_degree = 0.0
var PlayerScaleX
var PlayerScaleY
var WeaponSpriteX
var WeaponScaleX
var WeaponScaleY

export var MAX_SPEED = 150
export var FRICTION = 100
export var ACCELERATION = 20
export var FACTOR = 1

onready var PlayerSprite = $PlayerSprite
onready var WeaponSprite = $WeaponSprite
onready var PlayerAnimator = $AnimationPlayer

func _ready():
	PlayerAnimator.play("IDLE")
	WeaponSpriteX = WeaponSprite.position.x
	WeaponScaleX = WeaponSprite.scale.x
	WeaponScaleY = WeaponSprite.scale.y
	PlayerScaleX = PlayerSprite.scale.x
	PlayerScaleY = PlayerSprite.scale.y
	
func toggle_visibility(TargetSprite):
	if TargetSprite.visible == true:
		TargetSprite.visible = false
	elif TargetSprite.visible == false:
		TargetSprite.visible = true
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
func rotate_sprite(WeaponSprite,PlayerSprite):
	var m_degree = get_global_mouse_position().angle_to_point(position)
	WeaponSprite.look_at(get_global_mouse_position())
	if m_degree > -1.5 && m_degree < 1.5:
		PlayerSprite.scale.x = PlayerScaleX * 1
		WeaponSprite.scale.y = WeaponScaleY * 1
	else:
		PlayerSprite.scale.x = PlayerScaleX * -1
		WeaponSprite.scale.y = WeaponScaleY * -1
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_toggleweapon") == true:
		toggle_visibility(WeaponSprite)
	rotate_sprite(WeaponSprite,PlayerSprite)
	velocity = get_movement(velocity)
	move_and_slide(velocity)
