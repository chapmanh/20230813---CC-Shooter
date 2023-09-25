extends BaseLevel

func _on_gate_entered(_body):
	var tween = create_tween()
	tween.tween_property(%Player, "speed", 0, 0.5)

func _on_house_player_entered(_body):
	adjust_zoom(indoor_zoom)
	
func _on_house_player_exited(_body):
	adjust_zoom(outdoor_zoom)
