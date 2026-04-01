extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect


func _on_color_rect_gui_input(event: InputEvent) -> void:
	print("Got Click")
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		print("Passed If")
		GlobalState.sceneManager.changeNodeOne("res://NonLessonScenes/ChapterSelect.tscn")
