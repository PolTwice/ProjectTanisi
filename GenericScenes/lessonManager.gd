extends Node

@onready var text_box: Control = $TextBox
@onready var quiz_box: Control = $QuizBox

#Hold index of current story or 
@onready var lessonIndex = 0
@onready var storyIndex = text_box.currentIndex 
@onready var quizIndex = 0

@export var storyResource: Resource
#hold an array of resource for the quiz.
@export var quizResourceArray: Array[Resource]
@onready var quizResource: Resource
#create an enum for the export
enum ContentType { QUIZ, STORY }
@export var order: Array[ContentType] = []

func _ready() -> void:
	if(order == null || quizResourceArray == null):
		text_box.visible = false;
		quiz_box.visible = false;
		print("Order export is empty. Program does not know the order of quizzes and stories. ")
		return;

func _on_text_box_story_next_signal() -> void:
	text_box.currentIndex = storyIndex

func _on_text_box_story_back_signal() -> void:
	text_box.currentIndex = storyIndex
	
func _on_quiz_box_quiz_next_signal() -> void:
	quizIndex = quizIndex +1

func _on_quiz_box_quiz_back_signal() -> void:
	quizIndex = quizIndex -1
	
func checkNext() -> void:
	if(order[lessonIndex] != null):
		if(order[lessonIndex] == ContentType.STORY):
			quiz_box.visible == false;
			text_box.show_line(storyIndex)
			pass
		else:
			quizResource == quizResourceArray[quizIndex];
			quiz_box.updateFromResource()
			pass
	else:
		lessonComplete()
		
func lessonComplete():
	pass;
