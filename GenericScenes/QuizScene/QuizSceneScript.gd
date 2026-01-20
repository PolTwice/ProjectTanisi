extends CanvasLayer

@onready var h_box_ab: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB
@onready var h_box_cd: HBoxContainer = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD

@onready var button_a: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA
@onready var button_a_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA/buttonAVBox/buttonAPic
@onready var button_a_text: RichTextLabel = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerA/ButtonA/buttonAVBox/buttonAText

@onready var button_b: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB
@onready var button_b_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB/buttonBVBox/buttonBPic
@onready var button_b_text: RichTextLabel = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxAB/MarginContainerB/ButtonB/buttonBVBox/buttonBText

@onready var button_c: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC
@onready var button_c_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC/buttonCVBox/ButtonCPic
@onready var button_c_text: RichTextLabel = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerC/ButtonC/buttonCVBox/ButtonCText

@onready var button_d: Button = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD
@onready var button_d_pic: TextureRect = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD/buttonDVbox/ButtonDPic
@onready var button_d_text: RichTextLabel = $VBoxContainer/AnswerPanel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxCD/MarginContainerD/ButtonD/buttonDVbox/buttonDText

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
	A = 0, B = 1, C = 2, D = 3
}

@export var correctAnswer: answers 

var currentSelection: answers

func _on_ready() -> void:
	pass # Replace with function body.

func _on_submit_pressed() -> void:
	if currentSelection == correctAnswer:
		print("Right")
	else:
		print("Wrong")

func _on_button_a_toggled(toggled_on: bool) -> void:
	currentSelection = answers.A
	if(toggled_on):
		changeToggle(button_a)

func _on_button_b_toggled(toggled_on: bool) -> void:
	currentSelection = answers.B
	if(toggled_on):
		changeToggle(button_b)


func _on_button_c_toggled(toggled_on: bool) -> void:
	currentSelection = answers.C
	if(toggled_on):
		changeToggle(button_c)


func _on_button_d_toggled(toggled_on: bool) -> void:
	currentSelection = answers.D
	if(toggled_on):
		changeToggle(button_d)
	pass # Replace with function body.

func changeToggle(button: Button) -> void:
	var allButtons = [button_a, button_b, button_c, button_d]
	for curButton in allButtons:
		if curButton == button:
			continue
		else:
			curButton.toggleMode = false
	pass
