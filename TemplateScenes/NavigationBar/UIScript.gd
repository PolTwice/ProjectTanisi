class_name MainUI extends Control
#script attached to the main UI

@onready var back: Button = $HBoxContainer/LeftMargin/BackMargin/Back
@onready var info: Button = $HBoxContainer/MidMargin/PageInfoMargin/Info
@onready var account: Button = $HBoxContainer/RightMargin/AccountInfoMargin/Account

#Emit to container
signal changeNodeContainerOne

func _ready() -> void:
	
	pass
	
func _on_back_pressed() -> void:
	#if backStack is empty, backScene is null
	GlobalState.sceneManager.backNodeOne()
	
func _on_info_pressed() -> void:
	
	pass # Replace with function body.


func _on_account_pressed() -> void:
	print("Account Button Pressed")
	pass # Replace with function body.
