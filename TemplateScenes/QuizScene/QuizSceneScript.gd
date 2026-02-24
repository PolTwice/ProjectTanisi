extends CanvasLayer

#node for holding the question
@onready var question_text: RichTextLabel = $VBoxContainer/QuestionPanel/QuestionText

#Hboxes that hold button ab and cd
@onready var h_box_ab: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB
@onready var h_box_cd: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD

#Button, picture, and text for each answer
@onready var button_a: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA
@onready var button_a_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA/buttonAVBox/buttonAPic
@onready var button_a_text: Label = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA/buttonAVBox/buttonAText

@onready var button_b: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB
@onready var button_b_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB/buttonBVBox/buttonBPic
@onready var button_b_text: Label = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB/buttonBVBox/buttonBText

@onready var button_c: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC
@onready var button_c_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC/buttonCVBox/ButtonCPic
@onready var button_c_text: Label = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC/buttonCVBox/buttonCText

@onready var button_d: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD
@onready var button_d_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD/buttonDVbox/ButtonDPic
@onready var button_d_text: Label = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD/buttonDVbox/buttonDText

#button for submitting answer
@onready var submit: Button = $VBoxContainer/SubmitPanel/Submit

#nodes for correct answers
@onready var correct_parent_margin: MarginContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/CorrectParentMargin
@onready var correct_picture: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/CorrectParentMargin/CorrectAnswer/CorrectVBox/CorrectPicture
@onready var correct_answer_text: Label = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/CorrectParentMargin/CorrectAnswer/CorrectVBox/CorrectMargin/CorrectAnswerText

#incorrect answer text
@onready var incorrect_answer_label: Label = $IncorrectAnswerLabel

#text for the question
@export var question: String

#Text for what it says when you get the right answer
@export var correctAnswerText: String

#does this question have pictures?
@export var hasPictures = false

#does this question have four choice? if false, it has 2
@export var hasFourQuestions = true

#Text for each button
@export var buttonAText: String
@export var buttonBText: String
@export var buttonCText: String
@export var buttonDText: String

#picture for each button if there is one
@export var buttonAPic: Texture
@export var buttonBPic: Texture
@export var buttonCPic: Texture
@export var buttonDPic: Texture

signal canContinue

#enum for correct answer used in Export. 
enum answers{
	A=0, B=1, C=2 ,D=3
}

@export var correctAnswer: answers 

var correctAnswerButItsAString: String
var currentSelection;

func _on_ready() -> void:
	TransitionManager.make_invisible(incorrect_answer_label)
	question_text.text = question
	correct_answer_text.text = correctAnswerText
	
	match correctAnswer:
		answers.A:
			correctAnswerButItsAString = "A"
			if hasPictures:
				correct_picture.texture = buttonAPic
		answers.B:
			correctAnswerButItsAString = "B"
			if hasPictures:
				correct_picture.texture = buttonBPic
		answers.C:
			correctAnswerButItsAString = "C"
			if hasPictures:
				correct_picture.texture = buttonCPic
		answers.D:
			correctAnswerButItsAString = "D"
			if hasPictures:
				correct_picture.texture = buttonDPic
			
	print("The correct answers is "+ correctAnswerButItsAString )
	if hasPictures:
		button_a_pic.texture = buttonAPic
		button_b_pic.texture = buttonBPic
		button_c_pic.texture = buttonCPic
		button_d_pic.texture = buttonDPic
	else:
		button_a_pic.visible = false
		button_b_pic.visible = false
		button_c_pic.visible = false
		button_d_pic.visible = false

	if !hasFourQuestions:
		h_box_cd.visible = false

	button_a_text.text = buttonAText
	button_b_text.text = buttonBText
	button_c_text.text = buttonCText
	button_d_text.text = buttonDText

func _on_submit_pressed() -> void:
	#Check if right answer
	print("Current Slesction: ")
	print(currentSelection)
	print("Correct Answer")
	print(correctAnswerButItsAString)
	
	if currentSelection == correctAnswerButItsAString:
		correctAnswerFunc()
		
	else:
		incorrectAnswerFunc()
		
func _on_button_a_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		currentSelection = "A"
		print("A toggled on")
		changeToggle(button_a)

func _on_button_b_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		currentSelection = "B"
		print("B toggled on")
		changeToggle(button_b)

func _on_button_c_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		currentSelection = "C"
		print("C toggled on")
		changeToggle(button_c)

func _on_button_d_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		currentSelection = "D"
		print("D toggled on")
		changeToggle(button_d)

func changeToggle(button: Button) -> void:
	submit.disabled = false
	var allButtons = [button_a, button_b, button_c, button_d]
	for curButton in allButtons:
		if curButton == button:
			continue
		else:
			curButton.button_pressed = false
			
func incorrectAnswerFunc():
	match currentSelection:
		"A":
			TransitionManager.fade_out(button_a,0.5)
		"B":
			TransitionManager.fade_out(button_b,0.5)
		"C":
			TransitionManager.fade_out(button_c,0.5)
		"D":
			TransitionManager.fade_out(button_d,0.5)
	
	TransitionManager.make_visible(incorrect_answer_label)
	await TransitionManager.pause_for(2.0)
	TransitionManager.fade_out(incorrect_answer_label)
	
	

func correctAnswerFunc():
	h_box_ab.visible = false
	h_box_cd.visible = false
	correct_parent_margin.visible = true
	submit.visible = false
	canContinue.emit()
	
