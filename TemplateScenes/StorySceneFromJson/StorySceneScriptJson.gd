extends Control

@onready var side_left_margin: MarginContainer = $"List Margin/ListContainer/SideLeft/SideLeftMargin"
@onready var side_right_margin: MarginContainer = $"List Margin/ListContainer/SideRight/SideRightMargin"

const BUTTON_THEME = preload("uid://byi38q23oj3ta")


var dirPath = "user://generatedStories"

signal canContinue




#get a list of all files in the dirPath
func getFileNames(path) -> Array[String]:
	var dir = DirAccess.open(path)
	if dir:
		var fileContents: Array[String]
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			fileContents.append(file_name)
			file_name = dir.get_next()
		return fileContents
	else:
		print("An error occurred when trying to access the path.")
		return []

func createButton(fileName: String) -> Button:
	var newButton = Button.new()
	newButton.theme = BUTTON_THEME
	
	newButton.pressed.connect(_button_pressed(fileName))
	
	return newButton

func _button_pressed(fileName: String):
	#transition to new scene
	pass
