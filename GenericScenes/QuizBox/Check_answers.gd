extends Control

@onready var label: Label = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/TextboxDesign/Label
@onready var picture: TextureRect = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/Picture
@onready var button_a: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonABBox/ButtonA
@onready var button_b: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonABBox/ButtonB
@onready var button_c: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonCDBox/ButtonC
@onready var button_d: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonCDBox/ButtonD
@onready var button_ab_box: HBoxContainer = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonABBox
@onready var button_cd_box: HBoxContainer = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/UnderTextContainer/QuizQuestionBox/ButtonCDBox
@onready var back: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/MarginContainer/Back
@onready var listen_again: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/MarginContainer3/ListenAgain
@onready var submit: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/MarginContainer2/Submit

@export var quizResource: Resource
	#var choices = [0,0,0,0]
	#var correctIndex = -1
	#var picture: Texture

var correct_option = null

func _ready():
	button_a.text = quizResource.choices[0]
	button_b.text = quizResource.choices[1]
	button_c.text = quizResource.choices[2]
	button_d.text = quizResource.choices[3]
	
	if quizResource.picture == null:
		picture.visible = false
	else:
		picture.texture = quizResource.picture
	
	#if the second and third choice are not entered, then hide the box	
	if quizResource.choices[2] == "0" && quizResource.choices[3] == "0":
		button_cd_box.visible=false;

func _on_button_a_pressed() -> void:
	checkAnswer(0);

func _on_button_b_pressed() -> void:
	checkAnswer(1)

func _on_button_c_pressed() -> void:
	checkAnswer(2)

func _on_button_d_pressed() -> void:
	checkAnswer(3)

func checkAnswer(option: int) -> void:
	if(option == quizResource.correctIndex):
		print("Right Answer")
	else:
		print("Wrong Answer")
