extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP
var friendly: bool = false

func _ready():
	$SelfDestructTimer.start()

func _process(delta): 
	position += direction * speed * delta

func _on_body_entered(body):
	#print(String.num_int64(collision_mask, 2))	
	if body.has_method("hit"):
		#if "hit" in body:
#		if collision_mask&1<<0 == 0: # Player mask layer (layer 1) is false
		if body in get_tree().get_nodes_in_group("Container") and friendly: # Player mask layer (layer 1) is false
			body.hit()
		elif body not in get_tree().get_nodes_in_group("Container"):
			body.hit()
	queue_free()
 
func _on_self_destruct_timer_timeout():
	queue_free()
