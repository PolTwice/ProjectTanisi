extends Node

@onready var text_box: Control = $TextBox
@onready var quiz_box: Control = $QuizBox

#Hold index of current story or 
@onready var lessonIndex = 0
@onready var storyIndex = 0
@onready var quizIndex = 0

@export var lessonName: String;

#The resource for the story
@export var storyResource: Resource
#hold an array of resource for the quiz.
@export var quizResourceArray: Array[Resource]
#use this to hold the current resource
@onready var quizResourceParent;

#create an enum for the export
enum ContentType { QUIZ, STORY }
@export var order: Array[ContentType] = []

func _ready() -> void:
	#if there is a resource
	if(!(order == null && quizResourceArray == null && storyResource ==null)):
		checkNext()
	else:
		text_box.visible = false;
		quiz_box.visible = false;

func _on_text_box_story_next_signal() -> void:
	storyIndex = storyIndex +1
	checkNext();

func _on_text_box_story_back_signal() -> void:
	storyIndex = storyIndex -1
	checkNext();
func _on_quiz_box_quiz_next_signal() -> void:
	quizIndex = quizIndex +1
	checkNext();

func _on_quiz_box_quiz_back_signal() -> void:
	quizIndex = quizIndex -1
	checkNext();
	
func checkNext() -> void:
	if(lessonIndex < order.size()):
		print("Order is:")
		if(order[lessonIndex] == ContentType.STORY):
			quiz_box.visible = false;
			text_box.show_line(storyIndex)
		else:
			quizResourceParent = quizResourceArray[quizIndex];
			quiz_box.updateFromResource()
	else:
		lessonComplete()
		
func lessonComplete():
	pass;
