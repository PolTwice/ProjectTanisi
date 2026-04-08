extends Label

var score = 0
var winningScore = 5

signal win

func _on_flower_flower_collected() -> void:
	score += 1
	if score == 1:
		self.text = "You collected " +str(score) + " flower"
	else:
		self.text = "You collected " +str(score) + " flowers"
	
	if (score >= winningScore):
		self.text = "You did it!"
		win.emit()
