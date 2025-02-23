extends CharacterBody2D

signal primary(pos: Vector2, dir: Vector2)
signal secondary(pos: Vector2, dir: Vector2)
signal out_of_ammo(ammo_type: int)

var can_primary: bool = true
var can_secondary: bool = true

@export var max_speed: float = 500
var speed: float = max_speed
var sprint_mult: float = 1.5

func _ready():
	$CollisionShape2D.polygon = $LightOccluder2D.occluder.polygon
	
func _process(_delta):
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	var player_facing = (get_global_mouse_position() - position).normalized()
	
	# rotate - look at mouse
	look_at(get_global_mouse_position())
	rotate(PI/2)
	
	# primary action
	if (Input.is_action_just_pressed("primary action") 
			and can_primary
	):
		if Globals.primary_amount > 0:
			Globals.primary_amount -= 1 #Update primary
			Globals.laser_amount = Globals.primary_amount #Backup value to specific weapon
			can_primary = false
			$PrimaryTimer.start()
			var pos = $LaserStartPositions.get_children().pick_random().global_position
			var dir = player_facing
			primary.emit(pos, dir)
			$LaserStartPositions/Marker2D/GPUParticles2D.restart()
			$LaserStartPositions/Marker2D/GPUParticles2D.emitting = true
		else:
			out_of_ammo.emit(1)
	
	# Secondary action
	if (Input.is_action_just_pressed("secondary action")
			and can_secondary
	):
		if Globals.secondary_amount > 0:
			can_secondary = false
			$SecondaryTimer.start()
			var pos = $LaserStartPositions.get_children()[0].global_position
			var dir = player_facing
			secondary.emit(pos, dir)
		else:
			out_of_ammo.emit(2)

	if Input.is_action_pressed("sprint"):
		speed = max_speed * sprint_mult
	else:
		speed = max_speed
		
	if Input.is_action_just_pressed("utility"):
		$Flashlight.enabled = not $Flashlight.enabled

func _on_primary_timer_timeout():
	can_primary = true
	
func _on_secondary_timer_timeout():
	can_secondary = true

#func enable_lighting(b :bool):
#	print("Player lighting check!")
#	$PointLight2D.enabled = b
