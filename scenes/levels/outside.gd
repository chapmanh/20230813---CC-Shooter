extends BaseLevel

var inside_level: PackedScene = preload("res://scenes/levels/inside.tscn")

func _on_gate_entered(_body):
	var tween = create_tween()
	tween.tween_property(%Player, "speed", 0, 0.5)
#	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
	get_tree().change_scene_to_packed(inside_level)

func _on_house_player_entered(_body):
	adjust_zoom(ZOOM_INDOORS)
	
func _on_house_player_exited(_body):
	adjust_zoom(ZOOM_OUTDOORS)
