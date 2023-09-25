extends Node2D
class_name BaseLevel

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")

const indoor_zoom: float = 0.6
const outdoor_zoom: float = 0.4 

func _on_player_primary(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = dir.angle() + PI/2
	laser.direction = dir
	$Projectiles.add_child(laser)

func _on_player_secondary(pos, dir):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	grenade.rotation = randf()*2*PI
	grenade.angular_velocity = randf_range(-1, 1) * 2 * PI
	$Projectiles.add_child(grenade)

func adjust_zoom(zoom_value):
	var tween = create_tween()
	tween.tween_property(%Player/Camera2D, "zoom", Vector2(zoom_value, zoom_value), 1).set_trans(Tween.TRANS_SINE)
