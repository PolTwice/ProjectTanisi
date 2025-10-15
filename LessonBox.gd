class_name lessonBox extends Control


signal quizNextSignal();
signal quizBackSignal();



func _ready():
	#when does this get enabled? will we have audio?
	#Commenting out until decided
	#listen_again.disabled = true
	#back.disabled=true;
	
	if(quizResource!=null):
		updateFromResource()

func updateFromResource():
	button_a.text = quizResource.choices[0]
	button_b.text = quizResource.choices[1]
	button_c.text = quizResource.choices[2]
	button_d.text = quizResource.choices[3]
	
	#if there is no picture, hide the picture, else change the texture
	if quizResource.picture == null:
		picture.visible = false
	else:
		picture.texture = quizResource.picture
	
	#if the second and third choice are not entered, then hide the box	
	if quizResource.choices[2] == "0" && quizResource.choices[3] == "0":
		button_cd_box.visible=false;
		quizResource.correctIndex = 0
		
		
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
