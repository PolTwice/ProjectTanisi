extends Area2D


signal flowerCollected



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Bird":
		flowerCollected.emit();
		spawn_randomly()
		
func spawn_randomly():
	# Move the flower to a new spot on the screen
	var screen_size = get_viewport_rect().size
	position.x = randf_range(200, screen_size.x - 200)
	position.y = randf_range(200, screen_size.y - 200)


func _on_tree_entered() -> void:
	spawn_randomly()
	pass # Replace with function body.
