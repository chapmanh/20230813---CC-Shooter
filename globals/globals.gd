extends Node

signal health_change
signal ammo_change(ammo_type: int)

var laser_scene: PackedScene = preload("res://scenes/Projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/Items/item.tscn")

var primary_amount: int = -1:
	get:
		return primary_amount
	set(value):
		primary_amount = value
		ammo_change.emit(1)
var secondary_amount: int = -1:
	get:
		return secondary_amount
	set(value):
		secondary_amount = value
		ammo_change.emit(2)
var health: int = 100:
	get:
		return health
	set(value):
		health = min(value, health_max)
		health_change.emit()

var health_max: int = 100

var laser_amount: int = 50
var grenade_amount: int = 10

var player_pos: Vector2

func _ready():
	pass
	primary_amount = laser_amount
	secondary_amount = grenade_amount
