extends StaticBody2D

signal entered(body)

func _on_area_2d_body_entered(body):
	entered.emit(body)
