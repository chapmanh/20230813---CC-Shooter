extends CharacterBody2D

signal primary(pos)
signal secondary(pos)

var can_primary: bool = true
var can_secondary: bool = true

func _process(_delta):
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_primary:
		can_primary = false
		$PrimaryTimer.start()
		primary.emit($LaserStartPositions.get_children().pick_random().global_position)
	
	# grenade input
	if Input.is_action_just_pressed("secondary action") and can_secondary:
		can_secondary = false
		$SecondaryTimer.start()
		secondary.emit($LaserStartPositions.get_children()[0].global_position)

func _on_primary_timer_timeout():
	can_primary = true
	
func _on_secondary_timer_timeout():
	can_secondary = true
