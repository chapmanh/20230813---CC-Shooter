extends StaticBody2D
class_name BaseItemContianer
signal opened(pos, dir)

@export var item_name: String = "BaseItemContainer_CHANGEME"
@export var item_count_min: int = 0
@export var item_count_max: int = 0

@onready var current_direction: Vector2
@onready var item_cap: int = $ItemSpawnPoints.get_child_count()

func _ready():
	current_direction = Vector2.DOWN.rotated(rotation)
	item_count_max = min(item_count_max, item_cap)

func hit():
	#print("Hit: {o}".format({'o':item_name}))
	
	if $ContainerLid.visible:
		$ContainerLid.visible = false
	
		# Allocate Spawn Positions
		if item_cap > 0 and item_count_min > 0:
			var spawn_points: Array[Node] = $ItemSpawnPoints.get_children()
			#get number of items to produce
			var n_items = randi_range(item_count_min, item_count_max)
			while n_items > 0:
				var i: int = randi() % len(spawn_points)
				opened.emit(spawn_points.pop_at(i).global_position, current_direction)
				#item_cap -= 1
				n_items -= 1
	

