extends KinematicBody2D


const UP = Vector2(0,-1);
const Gravity = 40;
const MaxFallSpeed = 200;
const PMaxSpeed = 80;
const NMaxSpeed = -80;
const JumpForce = 500; 
const Acceleration = 40;

var facing_right = true;
var Jumped = false;
var Motion = Vector2.ZERO;
var InputVector = Vector2.ZERO;
func _ready():
	pass 
func _physics_process(delta):
	if Input.is_action_pressed("ui_restart"):
		get_tree().reload_current_scene();
	Motion.y += Gravity;
	if facing_right:
		$Body.scale.x=1;
		$Arm.scale.x=1;
		$Cloak.scale.x=1;
	elif !(facing_right):
		$Body.scale.x=-1;
		$Arm.scale.x=-1;
		$Cloak.scale.x=-1;
	if Motion.y > MaxFallSpeed:
		Motion.y = MaxFallSpeed;
	if Motion.x > PMaxSpeed:
		Motion.x = PMaxSpeed;
	elif Motion.x < NMaxSpeed:
		Motion.x = NMaxSpeed;
	InputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	InputVector = InputVector.normalized();
	if InputVector.x != 0:
		if InputVector.x >0:
			Motion.x += (InputVector.x * delta * Acceleration) + 10;
		elif InputVector.x <0:
			Motion.x += (InputVector.x * delta * Acceleration) - 10; 
		$Body/BodyAnimation.play("BodyRunning");
		$Arm/ArmAnimation.play("ArmRunning");
	else:
		Motion.x = 0;
	if Input.is_action_pressed("ui_right"):
		facing_right = true;
	elif Input.is_action_pressed("ui_left"):
		facing_right = false;  
	else:
		$Body/BodyAnimation.play("RESET");
		$Arm/ArmAnimation.play("RESET");
	if Input.is_action_pressed("ui_up") and Jumped==false:
		Jumped=true;
		Motion.y = -JumpForce;
	if Motion.y > 0 and !(is_on_floor()):
		$Cloak/CloakAnimation.play("Falling");
	else:
		$Cloak/CloakAnimation.play("CloakIdle");
	if is_on_floor():
		Jumped=false;
	Motion = move_and_slide(Motion,UP);
