extends BaseLevel

@export var outside_level_scene: PackedScene

func _on_entrance_body_entered(_body):
	var tween = create_tween()
	tween.tween_property(%Player, "speed", 0, 0.5)
	get_tree().change_scene_to_packed(outside_level_scene)
