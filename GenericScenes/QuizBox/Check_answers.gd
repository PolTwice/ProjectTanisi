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

@export var quizResouce: Resource

var correct_option = null

func _ready():
	$Right.visible = false
	$Wrong.visible = false

# --- Button Signals ---
func _on_button_a_button_down():
	check_option(true)   # correct

func _on_button_b_button_down():
	check_option(false)

func _on_button_c_button_down():
	check_option(false)

func _on_button_d_button_down():
	check_option(false)



# --- Main Logic ---
func check_option(is_correct: bool):
	if is_correct:
		$Right.visible = true
		$Wrong.visible = false
	else:
		$Right.visible = false
		$Wrong.visible = true


func _on_button_a_pressed() -> void:
	pass # Replace with function body.


func _on_button_b_pressed() -> void:
	pass # Replace with function body.


func _on_button_c_pressed() -> void:
	pass # Replace with function body.


func _on_button_d_pressed() -> void:
	pass # Replace with function body.
