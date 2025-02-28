extends CharacterBody2D

var speed_ratio: float = 150
var max_speed: float
var speed: float = 0.0
var direction: Vector2
@export var health: int = 70

@onready var body_scale: float = $Body.scale[0]

var state:int = 0:
	get:
		return state
	set(value):
		state = value
		if value == 0:
			print('waiting')
			all_clear()
		if value == 1:
			print('chasing')
			threat_found()
		if value == 2:
			print('attacking')
			attack()
			
			

func _ready():
	max_speed = speed_ratio / sqrt(body_scale)
	$Body/AnimatedSprite2D.speed_scale = 1 - body_scale
	
func _process(_delta):
	if state == 0:
		speed = 0
	if state == 1:
		direction = (Globals.player_pos - global_position).normalized()
		speed = max_speed
		look_at(Globals.player_pos)
	if state == 2:
		speed = 0
		look_at(Globals.player_pos)
		if not $Body/AnimatedSprite2D.is_playing():
			print("finished attacking")
			print($Body/AttackRange.get_overlapping_bodies())
			print($Body/AttackRange.get_overlapping_areas())
			print($VisionRange.get_overlapping_bodies())
			print($VisionRange.get_overlapping_areas())
			if $Body/AttackRange.has_overlapping_bodies():
				for body in $Body/AttackRange.get_overlapping_bodies():
					if "hit" in body:
						body.hit(10)
				print("still in attack range")
				state = 2
			elif $VisionRange.has_overlapping_bodies():
				print()
				print("still in chase range")
				state = 1
			else:
				print("not visible")
				state = 0
	velocity = direction * speed
	move_and_slide()
		
func all_clear():
	$Body/AnimatedSprite2D.play("idle")
	
func threat_found():
	$Body/AnimatedSprite2D.play("walk")
	
func attack():
	$Body/AnimatedSprite2D.play("attack")
	
func hit(d):
	var tween = create_tween()
	tween.tween_property( $Body/AnimatedSprite2D, 
		"material:shader_parameter/progress",
		1,
		0.01
	)
	tween.tween_property(
		$Body/AnimatedSprite2D, 
		"material:shader_parameter/progress",
		0,
		0.5
	)
#	tween.play()
	health -= d
	if health <= 0:
		queue_free()
	
func _on_vision_body_entered(_body):
	state = 1

func _on_vision_body_exited(_body):
	state = 0

func _on_attack_range_body_entered(_body):
	state = 2
