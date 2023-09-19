extends CharacterBody2D

signal primary(pos: Vector2, dir: Vector2)
signal secondary(pos: Vector2, dir: Vector2)

var can_primary: bool = true
var can_secondary: bool = true

func _ready():
	$CollisionShape2D.polygon = $LightOccluder2D.occluder.polygon
	

func _process(_delta):
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 500
	move_and_slide()
	
	var player_facing = (get_global_mouse_position() - position).normalized()
	
	# rotate - look at mouse
	look_at(get_global_mouse_position())
	rotate(PI/2)
	
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_primary:
		can_primary = false
		$PrimaryTimer.start()
		var pos = $LaserStartPositions.get_children().pick_random().global_position
		var dir = player_facing
		primary.emit(pos, dir)
		$LaserStartPositions/Marker2D/GPUParticles2D.emitting = true
	
	# grenade input
	if Input.is_action_just_pressed("secondary action") and can_secondary:
		can_secondary = false
		$SecondaryTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		var dir = player_facing
		secondary.emit(pos, dir)

func _on_primary_timer_timeout():
	can_primary = true
	
func _on_secondary_timer_timeout():
	can_secondary = true
