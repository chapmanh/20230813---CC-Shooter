extends CanvasLayer

@onready var primary_label: Label = $AmmoMarginContainer/AmmoHBoxContainer/PrimaryVBoxContainer/PrimaryLabel
@onready var secondary_label: Label = $AmmoMarginContainer/AmmoHBoxContainer/SecondaryVBoxContainer/SecondaryLabel

func _ready():
	update_primary_label_text()
	update_secondary_label_text()

func update_primary_label_text():
	primary_label.text = str(Globals.primary_amount)
	
func update_secondary_label_text():
	secondary_label.text = str(Globals.secondary_amount)	
