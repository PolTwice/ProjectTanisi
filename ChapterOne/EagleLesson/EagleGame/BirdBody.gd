extends CharacterBody2D

@export var speed = 300

var gameWon = false

func _physics_process(_delta):
	if gameWon == false:
		# Get the position of the mouse or the last touch point
		var target = get_global_mouse_position()
		var velocity_direction = position.direction_to(target)
		
		# Only move if the bird isn't already "at" the finger/mouse
		if position.distance_to(target) > 10:
			velocity = velocity_direction * speed
			move_and_slide()
			
			# Make the bird face the direction it's flying
			look_at(target)

func _on_score_win() -> void:
	gameWon = true
	$"../Flower".queue_free()
	pass # Replace with function body.
