extends BaseItemContianer

func _ready():
	item_name = "Box"
	
func hit():
	$BoxLid.visible = false
	
