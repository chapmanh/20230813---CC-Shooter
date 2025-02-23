extends CanvasLayer

# colors
@export var loaded_color: Color = Color("6bbfa3") # hex code
@export var empty_color: Color = Color(0.9, 0, 0, 1) # RGBA

@onready var primary_label: Label = \
$AmmoMarginContainer/AmmoHBoxContainer/PrimaryVBoxContainer/PrimaryLabel
@onready var primary_icon: TextureRect = \
$AmmoMarginContainer/AmmoHBoxContainer/PrimaryVBoxContainer/PrimaryTextureRect

@onready var secondary_label: Label = \
$AmmoMarginContainer/AmmoHBoxContainer/SecondaryVBoxContainer/SecondaryLabel
@onready var secondary_icon: TextureRect = \
$AmmoMarginContainer/AmmoHBoxContainer/SecondaryVBoxContainer/SecondaryTextureRect

@onready var health_bar: TextureProgressBar = \
$HealthMarginContainer/HealthTextureProgressBar

func _ready():
	update_ammo(1)
	update_ammo(2)
	update_color(Globals.primary_amount, primary_label, primary_icon)
	update_color(Globals.primary_amount, secondary_label, secondary_icon)
	Globals.connect('health_change', update_health)
	Globals.connect('ammo_change', update_ammo)
	update_health()

func update_ammo(ammo_type: int):
	if ammo_type == 1: #Primary
		primary_label.text = str(Globals.primary_amount)
		update_color(Globals.primary_amount, primary_label, primary_icon)
	if ammo_type == 2: #Secondary
		secondary_label.text = str(Globals.secondary_amount)
		update_color(Globals.secondary_amount, secondary_label, secondary_icon)

func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = empty_color
		icon.modulate = empty_color
	else:
		label.modulate = loaded_color
		icon.modulate = loaded_color

func update_health():
	health_bar.value = Globals.health

func flash(node):
	var tween = create_tween()
	tween.tween_property(node, "modulate", Color.WHITE, 0.1)
	tween.tween_property(node, "modulate", empty_color, 0.1)
	tween.tween_property(node, "modulate", Color.WHITE, 0.1)
	tween.tween_property(node, "modulate", empty_color, 0.1)
	tween.tween_property(node, "modulate", Color.WHITE, 0.1)
	tween.tween_property(node, "modulate", empty_color, 0.1)
	tween.tween_property(node, "modulate", Color.WHITE, 0.1)
	tween.tween_property(node, "modulate", empty_color, 0.1)
	
func _on_player_out_of_ammo(ammo_type):
	if ammo_type == 1:
		flash(primary_icon)
		flash(primary_label)
	if ammo_type == 2:
		flash(secondary_icon)
		flash(secondary_label)
