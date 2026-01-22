extends CanvasLayer

@onready var question_text: RichTextLabel = $VBoxContainer/QuestionPanel/QuestionText

@onready var h_box_ab: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB
@onready var h_box_cd: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD

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

@onready var submit: Button = $VBoxContainer/SubmitPanel/Submit

@export var question: String

@export var hasPictures = false
@export var hasFourQuestions = true

@export var buttonAText: String
@export var buttonBText: String
@export var buttonCText: String
@export var buttonDText: String

@export var buttonAPic: Texture
@export var buttonBPic: Texture
@export var buttonCPic: Texture
@export var buttonDPic: Texture


enum answers{
	A=0, B=1, C=2 ,D=3
}

@export var correctAnswer: answers 

var correctAnswerButItsAString: String
var currentSelection;

func _on_ready() -> void:
	question_text.text = question
	
	match correctAnswer:
		answers.A:
			correctAnswerButItsAString = "A"
		answers.B:
			correctAnswerButItsAString = "B"
		answers.C:
			correctAnswerButItsAString = "C"
		answers.D:
			correctAnswerButItsAString = "D"
			
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
		print("Right")
	else:
		print("Wrong")

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
