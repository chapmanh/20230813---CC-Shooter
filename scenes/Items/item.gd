extends Area2D

var rotation_speed: float = 3.0
var rotation_dir: int = [-1, 1].pick_random()
var items: Dictionary = {
	"p": [0.5, Color.INDIAN_RED],
	"s": [0.3, Color.CADET_BLUE],
	"h": [0.2, Color.SEA_GREEN]
}

var item_colours: Dictionary = {
	"p": Color.INDIAN_RED,
	"S": Color.CADET_BLUE,
	"h": Color.SEA_GREEN
}

var item_type: String = choose_item()

var item_color: Color = items[item_type][1]

func _ready():
	modulate = item_color
	$Aura.color = item_color

func _process(delta):
	rotation += rotation_speed * rotation_dir * delta
	
func choose_item() -> String:
	var chance = randf()
	var cumulative: float = 0.0
#	return 'h'
	for k in items:
		cumulative += items[k][0]
		if chance <= cumulative:
			return k
	return ""
		
func item_spawn(dir):
	var item_hop_tween = create_tween()
	var n = randfn(0, 0.2) #64.2% of values between -0.2 and 0.2, 91.4% between -0.4 and 0.4
	#print(n)
	item_hop_tween.set_trans(Tween.TRANS_QUART)
	item_hop_tween.set_ease(Tween.EASE_OUT)
	item_hop_tween.tween_property(
		self,
		"position",
		position + dir.rotated(n*PI/2) * randi_range(150, 250), randf_range(0.5, 1.0)
	)

func _on_body_entered(_body):
	var collected: bool = false
	if item_type == "p":
		collected = true
		Globals.primary_amount += 10
		Globals.laser_amount = Globals.primary_amount
	if item_type == "s":
		collected = true
		Globals.secondary_amount += 3
		Globals.grenade_amount = Globals.secondary_amount
	if item_type == "h" and Globals.health < Globals.health_max:
		collected = true
		Globals.health += 10
	if collected:
		queue_free()
	
