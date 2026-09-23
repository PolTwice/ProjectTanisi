extends Control

var testFile = "test.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	makeLessonScene(parseFile(testFile), 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Get a json file and turn it into a dictionary
func parseFile(fileName: String) -> Dictionary:
	var jsonFile = FileAccess.open(GlobalState.dirPath + "/" + fileName, FileAccess.READ)
	var jsonParsed = JSON.parse_string(jsonFile.get_as_text())
	if jsonParsed != null:
		return jsonParsed
	else:
		return {0:0}

func isValidLesson(lessonDict):
	return lessonDict["title"] == null || lessonDict["scenes"] == null || lessonDict["scenes"]["scene_number"] == null || lessonDict["scenes"]["target_word"] == null || lessonDict["scenes"]["text"] == null
	
func getLessons(lessonDict: Dictionary):
	if lessonDict["scenes"] != null:
		return lessonDict["scenes"]
	else:
		return {null:null}

func makeLessonScene(lessonDict: Dictionary, sceneIndex: int):
	var lessonCount = lessonDict["scenes"].size()
	
	if (sceneIndex +1) > lessonCount:
		print("Lesson \"",lessonDict["title"],"\" has ", lessonCount, " scenes. You entered ", sceneIndex) 
		return
		
	var workingScene = lessonDict["scenes"][sceneIndex]
	
	var sceneNumber = workingScene["scene_number"]
	var targetWord = workingScene["target_word"]
	var text = workingScene["text"]
	
	print("Scene Number: ", sceneNumber)
	print("Target Word: ", targetWord)
	print("Text: ", text)
	pass
