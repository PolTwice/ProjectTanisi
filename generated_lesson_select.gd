extends Control

@onready var side_left: VBoxContainer = $"List Margin/ListContainer/SideLeftMargin/SideLeft"
@onready var side_right: VBoxContainer = $"List Margin/ListContainer/SideRightMargin/SideRight"

const BUTTON_THEME = preload("uid://byi38q23oj3ta")

var dirPath = "user://generatedStories"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var files = getFileNames(dirPath)
	print(files)
	var index = 0
	for file in files:
		if index % 2 == 0:
			side_left.add_child(createButton(file))
		else:
			side_right.add_child(createButton(file))
		index += 1
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	
	newButton.text = fileName
	#newButton.pressed.connect(_button_pressed(dirPath + fileName))
	
	return newButton

func _button_pressed(fileName: String):
	#GlobalState.sceneManager.changeNodeOne(fileName)
	pass
