extends Node

func fade_out(node: CanvasItem, duration := 1.0, alpha := 0.0) -> Tween: # Added '-> Tween'
	if node == null:
		return null
	
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "modulate:a", alpha, duration)
	tween.tween_callback(func(): node.visible = false)
	return tween 

func fade_in(node: CanvasItem, duration := 1.0, alpha := 1.0) -> Tween:
	if node == null:
		return null
	
	node.modulate.a = 0.0
	node.visible = true # Ensure it's visible before fading in!
	
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(node, "modulate:a", alpha, duration)
	return tween 
	
#await this function for it to work properly
func pause_for(duration) -> void:
	if duration == null:
		return
		
	await get_tree().create_timer(duration).timeout
	
#sets the node to alpha = 1.0 so that it is visible
#this will be nice for use for other transition
func make_visible(node: CanvasItem):
	if node == null:
		return
	node.modulate.a = 1.0

#sets the node to alpha = 0.0 so that it is invisible
#this will be nice for use for other transition
func make_invisible(node: CanvasItem):
	if node == null:
		return
	node.modulate.a = 0.0
