extends Node2D

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")

func _on_gate_entered(body):
	print("Body entered gate")
	print(body)


func _on_player_primary(pos):
	var laser = laser_scene.instantiate()
	# 1. update laser position and rotation
	laser.position = pos
	# 2. move laser
	# 3. add to a Node2D
	$Projectiles.add_child(laser)

func _on_player_secondary():
	print("Grenade thrown!")
