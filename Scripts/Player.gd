extends KinematicBody2D

const UP = Vector2(0,-1) 
const GRAVITY = 40
const MAX_FALLSPEED = 200
const PMAX_SPEED = 80
const NMAX_SPEED = -80
const SPEED_FX = 50
const JUMPFORCE = -600
const ACCELERATION = 50

var Status = 0
var Jumped = false
var facing_right = true
var motion = Vector2.ZERO
var input_vector = Vector2.ZERO
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_restart"):
		get_tree().reload_current_scene();
	motion.y += GRAVITY;
	if facing_right:
		$Sprite.scale.x = 1
	elif !(facing_right):
		$Sprite.scale.x = -1
	
	if motion.y > MAX_FALLSPEED:
		motion.y = MAX_FALLSPEED;
	
	if motion.x > PMAX_SPEED:
		motion.x = PMAX_SPEED;
	elif motion.x < NMAX_SPEED:
		motion.x = NMAX_SPEED;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	input_vector = input_vector.normalized();
	
	if input_vector.x != 0:
		if is_on_floor():
			$AnimationPlayer.play("Walking")
		if input_vector.x >0:
			motion.x += (input_vector.x * delta * ACCELERATION) + 10;
		elif input_vector.x <0:
			motion.x += (input_vector.x * delta * ACCELERATION) - 10; 
	else:
		motion.x = 0;
		if Jumped == false:
			$AnimationPlayer.play("Idle")
	
	if Input.is_action_pressed("ui_right"):
		facing_right = true;
	elif Input.is_action_pressed("ui_left"):
		facing_right = false;  
	
	if is_on_floor() and Jumped == true:
		Jumped=false;
		$AnimationPlayer.play("Idle")
	if Input.is_action_just_pressed("ui_up") and Jumped==false:
		Jumped=true;
		motion.y = JUMPFORCE;
		$AnimationPlayer.play("Jump")

	motion = move_and_slide(motion,UP);
	
	
