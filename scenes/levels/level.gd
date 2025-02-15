extends Node2D
class_name BaseLevel

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")

const ZOOM_INDOORS: float = 0.6
const ZOOM_OUTDOORS: float = 0.4

#var lighting_color: Color = Color(0.9, 1, 0.6, 0.9)
const LIGHTING_OFF: Color = Color(238/255.0, 247/255.0, 220/255.0, 222/255.0)
const LIGHTING_ON: Color = Color (0, 0, 0, 0)

#@export var level_lighting: bool = false
#signal set_level_lighting(v: bool)

func _on_player_primary(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = dir.angle() + PI/2
	laser.direction = dir
	$Projectiles.add_child(laser)
	$UI.update_primary_label_text()

func _on_player_secondary(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	grenade.rotation = randf()*2*PI
	grenade.angular_velocity = randf_range(-1, 1) * 2 * PI
	$Projectiles.add_child(grenade)
	$UI.update_secondary_label_text()

func adjust_zoom(zoom_value):
	var tween = create_tween()
#	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(
		%Player/Camera2D, 
		"zoom",
		Vector2(zoom_value, zoom_value),
		1
	)
