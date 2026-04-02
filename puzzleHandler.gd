extends Area2D

var dragging = false
var offset = Vector2.ZERO

@export var target_position = Vector2(400, 300) # Where the piece should go
@export var snap_threshold = 50.0 # Distance to auto-snap

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			offset = get_global_mouse_position() - global_position

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() - offset
	else:
		# Check if we are close enough to the right spot
		if global_position.distance_to(target_position) < snap_threshold:
			global_position = target_position
			set_process(false) # Lock the piece once placed
			print("Piece Snapped!")
