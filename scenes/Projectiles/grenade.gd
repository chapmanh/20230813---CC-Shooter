extends RigidBody2D

const speed = 750

func _ready():
	$Node/Explosion.rotation = randf_range(-PI, PI)

func explode():
	$CollisionShape2D.disabled = true
	$RemoteTransform2D.update_position = false
	print("Starting Explosion")
	$AnimationPlayer.play("explosion")
	
func free():
	self.call_deferred("queue_free")
