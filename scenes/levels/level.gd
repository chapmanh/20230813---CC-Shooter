extends Node2D
class_name BaseLevel

const ZOOM_INDOORS: float = 0.6
const ZOOM_OUTDOORS: float = 0.4

#var lighting_color: Color = Color(0.9, 1, 0.6, 0.9)
const LIGHTING_OFF: Color = Color(238/255.0, 247/255.0, 220/255.0, 222/255.0)
const LIGHTING_ON: Color = Color (0, 0, 0, 0)

#@export var level_lighting: bool = false
#signal set_level_lighting(v: bool)

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("opened", _on_container_opened)
		
	for scout in get_tree().get_nodes_in_group("Scout"):
		scout.connect("fire_primary", _on_scout_primary)

func _on_player_primary(pos, dir):
	fire_primary_weapon(pos, dir, Globals.laser_scene, 1)
	#$UI.update_ammo_label_text(1)

func _on_player_secondary(pos, dir):
	var grenade = Globals.grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.speed
	$Projectiles.add_child(grenade)

func _on_scout_primary(pos, dir):
	fire_primary_weapon(pos, dir, Globals.laser_scene, 2)

func fire_primary_weapon(pos: Vector2, dir: Vector2, projectile: PackedScene, mask: int):
	var proj = projectile.instantiate() as Area2D
	proj.set_collision_mask_value(mask, false) #No friendly fire
	proj.position = pos
	proj.rotation = dir.angle() + PI/2
	proj.direction = dir
	$Projectiles.add_child(proj)

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
	var item = Globals.item_scene.instantiate()
	item.position = pos
	$Items.call_deferred("add_child", item)
	item.item_spawn.call_deferred(dir)
	
	
