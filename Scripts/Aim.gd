extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) # Replace with function body.

func _physics_process(delta):
	$".".set_position(get_global_mouse_position());
	if Input.is_mouse_button_pressed(1):
		$Sprite.frame = 0
	else:
		$Sprite.frame = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
