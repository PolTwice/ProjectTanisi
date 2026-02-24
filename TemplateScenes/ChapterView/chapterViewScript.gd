extends Node2D

@onready var camera_2d: Camera2D = $Camera2D


func _on_ready() -> void:
	for child in get_children():
		if child.class_name == "lessonIcon":
			child.connect("currentPosition",Callable(self,"_lesson_selected"))

func _lesson_selected() -> void:
	#use the camera to zoom into the position given
	
	pass
