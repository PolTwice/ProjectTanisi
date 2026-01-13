extends Control

@onready var back_button: Button = $ButtonsCanvas/ButtonContainer/BackMargin/BackButton
@onready var next_button: Button = $ButtonsCanvas/ButtonContainer/NextMargin/NextButton

@onready var contents_canvas: CanvasLayer = $ContentsCanvas
@onready var lesson_complete: CanvasLayer = $LessonComplete

@onready var replay: Button = $"LessonComplete/Panel/Panel Margin/ContentsVBox/ButtonHbox/ReplayMargin/Replay"
@onready var go_back: Button = $"LessonComplete/Panel/Panel Margin/ContentsVBox/ButtonHbox/GoBackMargin/GoBack"

@export var lessonArray: Array[PackedScene]
@export var lessonName: StringName

var index = 0

func changeContents (new_scene: PackedScene):
	if contents_canvas != null:
		#remove each node
		for node in contents_canvas.get_children():
			node.queue_free()
	
	#instantiate the new scene
	var new = new_scene.instantiate()
	new.canContinue.connect(_can_continue)
	#make new scene a child of contents_canvas
	contents_canvas.add_child(new)
	
	#disable next button until canContinue signal is emitted
	next_button.disabled = true
	

func _on_ready() -> void:
	changeContents(changeContents(lessonArray[0]))
	

func _on_back_button_pressed() -> void:
	index -= 1
	
	if(index < 1):
		back_button.disabled = true
		return
	
	changeContents(lessonArray[index])
	
	next_button.disabled = false

func _on_next_button_pressed() -> void:
	index += 1
	
	if(index > lessonArray.size()):
		completeLesson()
		next_button.disabled = true
		return
	
	changeContents(lessonArray[index])
	back_button.disable = false

func completeLesson():
	lesson_complete.visible = true
	GlobalState.setLessonCompleted(lessonName, true)
	return

func _on_replay_pressed() -> void:
	changeContents(changeContents(lessonArray[0]))
	lesson_complete.visible = false


func _on_go_back_pressed() -> void:
	pass

func _can_continue() -> void:
	next_button.disabled = false
