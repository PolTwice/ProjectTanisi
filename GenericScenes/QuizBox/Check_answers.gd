extends Control

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
