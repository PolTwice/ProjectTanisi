extends Line2D

@export var max_points = 40 # How long the trail is
@onready var bird = get_parent()

func _process(_delta):
	# Add the bird's current position to the line
	add_point(bird.global_position)
	
	# If the trail gets too long, remove the oldest point
	if points.size() > max_points:
		remove_point(0)
