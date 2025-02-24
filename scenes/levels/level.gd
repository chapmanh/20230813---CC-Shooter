extends Node2D
class_name BaseLevel

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/Items/item.tscn")

const ZOOM_INDOORS: float = 0.6
const ZOOM_OUTDOORS: float = 0.4

#var lighting_color: Color = Color(0.9, 1, 0.6, 0.9)
const LIGHTING_OFF: Color = Color(238/255.0, 247/255.0, 220/255.0, 222/255.0)
const LIGHTING_ON: Color = Color (0, 0, 0, 0)

#@export var level_lighting: bool = false
#signal set_level_lighting(v: bool)

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		print(container)
		container.connect("opened", _on_container_opened)

func _on_player_primary(pos, dir):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation = dir.angle() + PI/2
	laser.direction = dir
	$Projectiles.add_child(laser)
	#$UI.update_ammo_label_text(1)

func _on_player_secondary(pos, dir):
	if Globals.secondary_amount > 0:
		Globals.secondary_amount -= 1
		Globals.grenade_amount = Globals.secondary_amount
		var grenade = grenade_scene.instantiate() as RigidBody2D
		grenade.position = pos
		grenade.linear_velocity = dir * grenade.speed
		grenade.rotation = randf()*2*PI
		grenade.angular_velocity = randf_range(-1, 1) * 2 * PI
		$Projectiles.add_child(grenade)

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

func _on_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	$Items.call_deferred("add_child", item)
	item.item_spawn.call_deferred(dir)
	
	
