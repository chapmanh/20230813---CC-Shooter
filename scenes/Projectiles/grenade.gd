extends RigidBody2D

const speed = 750

func explode():
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	print("Starting Explosion")
	$AnimationPlayer.play("explosion")
	
func free():
	self.call_deferred("queue_free")
