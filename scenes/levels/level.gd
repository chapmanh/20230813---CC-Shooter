extends Node2D

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")

func _on_gate_entered(body):
	print("Body entered gate")
	print(body)


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
