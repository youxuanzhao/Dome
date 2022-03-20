extends KinematicBody2D


const UP = Vector2(0,-1);
const Gravity = 20;
const MaxFallSpeed = 200;
const MaxSpeed = 80;
const JumpForce = 300; 

var facing_right = true;
var Jumped = false;
var Motion = Vector2.ZERO;
func _ready():
	pass 
func _physics_process(delta):
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
	if Input.is_action_pressed("ui_right"):
		Motion.x = MaxSpeed;
		facing_right = true;
		$Body/BodyAnimation.play("BodyRunning");
		$Arm/ArmAnimation.play("ArmRunning");
	elif Input.is_action_pressed("ui_left"):
		Motion.x = -MaxSpeed;
		facing_right = false;  
		$Body/BodyAnimation.play("BodyRunning");
		$Arm/ArmAnimation.play("ArmRunning");
	else:
		Motion.x = 0;
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
