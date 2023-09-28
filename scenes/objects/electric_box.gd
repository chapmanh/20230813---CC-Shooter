extends BaseItemContianer

func _ready():
	item_name = "ElectricBox"
	
func hit():
	$ElectricBoxLid.visible = false
	
