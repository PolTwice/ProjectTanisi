extends Node

@onready var text_box: Control = $TextBox
@onready var quiz_box: Control = $QuizBox

@export var storyResource: Resource
@export var quizResource: Resource


enum ContentType { QUIZ, STORY }
@export var order: Array[ContentType] = []

# Story Structure?
# hide quiz box if story,

func _on_text_box_story_next_signal() -> void:
	pass # Replace with function body.

func _on_text_box_story_back_signal() -> void:
	pass # Replace with function body.

func _on_quiz_box_quiz_next_signal() -> void:
	pass # Replace with function body.

func _on_quiz_box_quiz_back_signal() -> void:
	pass # Replace with function body.
