extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var opacity = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = opacity
	 # Replace with function body.

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):
		
		$AnimationPlayer.play("slash")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
