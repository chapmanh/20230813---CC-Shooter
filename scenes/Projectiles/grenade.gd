extends RigidBody2D

const speed = 750

func _ready():
	rotation = randf()*2*PI
	angular_velocity = randf_range(-1, 1) * 2 * PI
	$Node/Explosion.rotation = randf_range(-PI, PI)
	

func explode():
	$CollisionShape2D.disabled = true
	$RemoteTransform2D.update_position = false
	$AnimationPlayer.play("explosion")
	
func free():
	self.call_deferred("queue_free")
