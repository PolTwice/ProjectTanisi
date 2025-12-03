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
@onready var next: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/MarginContainer2/Next

@onready var question: Label = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/QuizContainer/TextboxDesign/Question

#get the resource from the parent
var quizResourceChild 
	#@var question: String
	#var choices = [0,0,0,0]
	#var correctIndex = -1
	#var picture: Texture

signal quizNextSignal();
signal quizBackSignal();

var correct_option = null

func updateFromResource():
	#Get parent resource. Update from it.
	quizResourceChild = get_parent().quizResourceParent
	question.text = quizResourceChild.question
	button_a.text = quizResourceChild.choices[0]
	button_b.text = quizResourceChild.choices[1]
	
	if quizResourceChild.choices.size() >2:
		button_c.text = quizResourceChild.choices[2]
		button_d.text = quizResourceChild.choices[3]
	else:
		button_cd_box.visible=false;
	
	#if there is no picture, hide the picture, else change the texture
	if quizResourceChild.picture == null:
		picture.visible = false
	else:
		picture.texture = quizResourceChild.picture
	
	#if the second and third choice are not entered, then hide the box	

		
		
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
		next.disabled = false;
	else:
		print("Wrong Answer")
		next.disabled = true;


func _on_back_pressed() -> void:
	emit_signal("quizBackSignal")
	print("Quiz Back signal sent")

func _on_listen_again_pressed() -> void:
	pass # Replace with function body.


func _on_next_pressed() -> void:
	emit_signal("quizNextSignal")
	print("Quiz next signal sent")
