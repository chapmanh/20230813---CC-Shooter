extends CharacterBody2D

var player_nearby: bool = false
var can_primary: bool = true

@onready var barrel_positions = $ScoutImage/BarrelPositions
@onready var barrel_cycle: int = randi() % barrel_positions.get_child_count()

signal fire_primary(pos: Vector2, dir: Vector2)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_primary:
			var pos: Vector2 = barrel_positions.get_children()[barrel_cycle].global_position
			barrel_cycle = (barrel_cycle+1)%barrel_positions.get_child_count()
			var dir: Vector2 = (Globals.player_pos - position).normalized()
			fire_primary.emit(pos, dir)
			can_primary = false
			$PrimaryTimer.start()

func hit():
	print('Scout hit!')

func _on_attack_area_body_entered(_body):
	player_nearby = true
	
func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_primary_timer_timeout():
	can_primary = true
