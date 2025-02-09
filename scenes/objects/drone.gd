extends CharacterBody2D

var is_enemy: bool = true

func _process(_delta):
	# direction
	var direction = Vector2.RIGHT
	
	# velocity
	velocity = direction * 400
	
	# move and slide
	move_and_slide()

func hit():
	print("damage")
