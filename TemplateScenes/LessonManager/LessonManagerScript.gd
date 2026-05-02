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

#change which module is loaded.
func changeContents (new_scene: PackedScene):
	#When there is the canvas isn't empty,
	if contents_canvas != null:
		#remove each node that is a child of the current contents_canvas
		for node in contents_canvas.get_children():
			node.queue_free()
	
	#instantiate the new scene
	var new = new_scene.instantiate()
	new.canContinue.connect(_can_continue)
	#make new scene a child of contents_canvas
	contents_canvas.add_child(new)
	
	#disable next button until canContinue signal is emitted
	#next_button.disabled = true
	
func _on_ready() -> void:
	#set the contents to the first scene in the lesson array
	changeContents(lessonArray[0])

func _on_back_button_pressed() -> void:
	#deincrement the index
	index -= 1
	
	#if index is 0 or less, we can't deincrement anymore
	if(index < 1):
		back_button.disabled = true

	changeContents(lessonArray[index])
	next_button.disabled = false

func _on_next_button_pressed() -> void:
	index += 1

	if(index >= lessonArray.size()):
		completeLesson()
		next_button.disabled = true
		return
	
	changeContents(lessonArray[index])
	back_button.disabled = false

func completeLesson():
	lesson_complete.visible = true
	GlobalState.setLessonCompleted(lessonName, true)
	return

func _on_replay_pressed() -> void:
	changeContents(lessonArray[0])
	lesson_complete.visible = false


func _on_go_back_pressed() -> void:
	GlobalState.sceneManager.backNodeOne()

func _can_continue() -> void:
	next_button.disabled = false
