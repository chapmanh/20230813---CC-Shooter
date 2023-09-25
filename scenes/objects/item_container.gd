extends StaticBody2D
class_name BaseItemContianer

var item_name: String = "BaseItemContainer_CHANGEME"

func _ready():
	print(item_name)

func hit():
	print("Hit: {o}".format({'o':item_name}))

