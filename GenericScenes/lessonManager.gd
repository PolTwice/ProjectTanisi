extends Node

@onready var text_box: Control = $TextBox
@onready var quiz_box: Control = $QuizBox
@onready var animation: Control = $Animation
@onready var resource_error: RichTextLabel = $ResourceError

#Hold index of current story or 
@onready var lessonIndex = 0
@onready var storyIndex = 0
@onready var quizIndex = 0

#title for title bar
@export var lessonName: String;

#The resource for the story
@export var storyResource: Resource
#hold an array of resource for the quiz.
@export var quizResourceArray: Array[Resource]
#use this to hold the current resource
@onready var quizResourceParent;

@export var animationResource: Resource

#create an enum for the export
enum ContentType { QUIZ, STORY }
@export var order: Array[ContentType] = []


func _ready() -> void:
	#if resource is invalid, hide everything and show an error
	if(isInvalidResources()):
		self.visible= false;
		resource_error.visible = true;
	#else check next
	else:
		checkNext()

func _on_text_box_story_next_signal() -> void:
	storyIndex = storyIndex +1
	lessonIndex +=1
	checkNext();

func _on_text_box_story_back_signal() -> void:
	storyIndex = storyIndex -1
	lessonIndex -=1
	checkNext();
	
	
func _on_quiz_box_quiz_next_signal() -> void:
	quizIndex = quizIndex +1
	lessonIndex +=1
	checkNext();

func _on_quiz_box_quiz_back_signal() -> void:
	if(quizIndex>0):
		quizIndex = quizIndex -1
	lessonIndex-=1
	checkNext();
	
func checkNext() -> void:
	if(lessonIndex < order.size()):
		print("Order is:")
		print(order[lessonIndex])
		if(order[lessonIndex] == ContentType.STORY):
			quiz_box.visible = false;
			text_box.show_line(storyIndex)
			animation.show_animation(storyIndex)
		else:
			quiz_box.visible = true
			quizResourceParent = quizResourceArray[quizIndex];
			await quiz_box.updateFromResource()
	else:
		lessonComplete()
		
func lessonComplete():
	pass;

func isInvalidResources() -> bool:
	#if no resources
	if(order == null || quizResourceArray == null || storyResource ==null || animationResource == null):
		return true
	#english and cree lines are not the same size
	if(storyResource.creeLines.size() != storyResource.englishLines.size()):
		return true
	#english and cree audio are not the same size
	if(storyResource.creeAudios.size() != storyResource.englishAudios.size()):
		return true
	#audios are not the same as the lines
	if(storyResource.creeLines.size() != storyResource.creeAudios.size()):
		return true
	#Num quizzes + num lines is not equal to order of all lines and quizzes
	if(order.size() != (quizResourceArray.size()+storyResource.creeLines.size())):
		return true
	#number of backgrounds is not equal to animations
	if(animationResource.backgrounds.size() != animationResource.animations.size()):
		return true
	#number of animations is not equal to amount of lines
	if(animationResource.backgrounds.size() != storyResource.creeLines.size()):
		return true
	#else looks good and we can work with the resources we have
	return false
