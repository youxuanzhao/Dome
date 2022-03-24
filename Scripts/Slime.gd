extends KinematicBody2D


const UP = Vector2(0,-1);
const Gravity = 40;
const MaxFallSpeed = 200;
const PMaxSpeed = 30;
const NMaxSpeed = -30;
const JumpForce = 500; 
const Acceleration = 40;

var facing_right = true;
var Jumped = false;
var Motion = Vector2.ZERO;
var Rotatecnt = 0;
func _ready():
	$AnimationPlayer.play("Idle");
	pass 
func _physics_process(delta):
	Rotatecnt+=1*delta;
	if Rotatecnt > 10:
		Rotatecnt=0;
		facing_right = !(facing_right);
	Motion.y += Gravity;
	if facing_right:
		$Sprite.scale.x=-1;
	elif !(facing_right):
		$Sprite.scale.x=1;
	if Motion.y > MaxFallSpeed:
		Motion.y = MaxFallSpeed;
	if Motion.x > PMaxSpeed:
		Motion.x = PMaxSpeed;
	elif Motion.x < NMaxSpeed:
		Motion.x = NMaxSpeed;
	
	if facing_right:
		Motion.x += Acceleration * delta;
	elif !(facing_right):
		Motion.x += Acceleration * delta * -1;
	

	Motion = move_and_slide(Motion,UP);
