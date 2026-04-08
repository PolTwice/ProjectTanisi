extends CanvasLayer

@onready var chap_1_panel: PanelContainer = $"Control/VBoxContainer/Button Margin/ButtonHbox/Chap1vBox/Chap1Panel"
@onready var chap_2_vbox: VBoxContainer = $"Control/VBoxContainer/Button Margin/ButtonHbox/Chap2Vbox"


func _on_chap_1_panel_gui_input(event: InputEvent) -> void:
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		GlobalState.sceneManager.changeNodeOne("res://ChapterOne/AnimalSelectScenes/0ChapterOne.tscn",)


func _on_panel_container_2_gui_input(event: InputEvent) -> void:
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		GlobalState.sceneManager.changeNodeOne("res://ChapterTwo/LessonSelectScenes/ChapterTwoLesson.tscn",)
