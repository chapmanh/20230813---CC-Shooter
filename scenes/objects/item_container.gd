extends StaticBody2D
class_name BaseItemContianer

@export var item_name: String = "BaseItemContainer_CHANGEME"

func _ready():
	pass

func hit():
	print("Hit: {o}".format({'o':item_name}))
	$ContainerLid.visible = false

