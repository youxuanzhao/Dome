extends KinematicBody2D

export var ScaleFactor = 1

onready var ObjectSprite = $ObjectSprite
onready var ObjectCollisionBox = $ObjectCollisionBox


func _process(delta):
	ObjectSprite.scale.x = ScaleFactor
	ObjectSprite.scale.y = ScaleFactor
	ObjectCollisionBox.scale.x = ScaleFactor
	ObjectCollisionBox.scale.y = ScaleFactor
