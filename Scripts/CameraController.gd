extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var FOV = 100.0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	zoom.x = float(FOV/100)
	zoom.y = float(FOV/100)
	pass # Replace with function body.

