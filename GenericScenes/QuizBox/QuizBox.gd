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

#get the resource from the parent
var quizResourceChild 
	#var choices = [0,0,0,0]
	#var correctIndex = -1
	#var picture: Texture

signal quizNextSignal();
signal quizBackSignal();

var correct_option = null

func _ready():
	#when does this get enabled? will we have audio?
	#Commenting out until decided
	#listen_again.disabled = true
	#back.disabled=true;
	quizResourceChild = get_parent().quizResourceParent
	if(quizResourceChild!=null):
		updateFromResource()

func updateFromResource():
	button_a.text = quizResourceChild.choices[0]
	button_b.text = quizResourceChild.choices[1]
	button_c.text = quizResourceChild.choices[2]
	button_d.text = quizResourceChild.choices[3]
	
	#if there is no picture, hide the picture, else change the texture
	if quizResourceChild.picture == null:
		picture.visible = false
	else:
		picture.texture = quizResourceChild.picture
	
	#if the second and third choice are not entered, then hide the box	
	if quizResourceChild.choices[2] == "0" && quizResourceChild.choices[3] == "0":
		button_cd_box.visible=false;
		quizResourceChild.correctIndex = 0
		
		
func _on_button_a_pressed() -> void:
	checkAnswer(0);

func _on_button_b_pressed() -> void:
	checkAnswer(1)

func _on_button_c_pressed() -> void:
	checkAnswer(2)

func _on_button_d_pressed() -> void:
	checkAnswer(3)

func checkAnswer(option: int) -> void:
	if(option == quizResourceChild.correctIndex):
		print("Right Answer")
		submit.disabled = false;
	else:
		print("Wrong Answer")
		submit.disabled = true;


func _on_back_pressed() -> void:
	emit_signal("quizBackSignal")
	print("Quiz Back signal sent")


func _on_listen_again_pressed() -> void:
	pass # Replace with function body.


func _on_next_pressed() -> void:
	emit_signal("quizNextSignal")
	print("Quiz next signal sent")
