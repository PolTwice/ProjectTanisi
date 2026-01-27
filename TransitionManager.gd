extends Node

func fade_out(node: CanvasItem, duration:= 1.0):
	if node == null:
		return
	
	node.modulate.a = 1.0
	
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "modulate:a", 0.0, duration)

func pause_for(duration) -> void:
	if duration == null:
		return
		
	await get_tree().create_timer(duration).timeout
	print("Do the next thing")
	
func make_visible(node: CanvasItem):
	if node == null:
		return
	node.modulate.a = 1.0
	
func make_invisible(node: CanvasItem):
	if node == null:
		return
	node.modulate.a = 0.0
