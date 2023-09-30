extends BaseLevel

var base_level = BaseLevel.new()

func _ready():
	base_level._ready()
	$DirectionalLight2D.color = LIGHTING_OFF
	$DirectionalLight2D.enabled = true
	print($DirectionalLight2D.color)
