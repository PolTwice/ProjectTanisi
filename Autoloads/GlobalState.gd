extends Node
#autoload singleton for storing global variables and references

#Declare and create the SceneManager so it is accessible. 
var sceneManager: SceneManager
var user = "PolTestUser"
var dirPath = "user://generatedStories"

var audioManager: AudioManager
#signal for lesson and quiz completion
signal lesson_completed(lesson_id: StringName)

# Holds lessons and whether they’re complete
# Example: { "beaver": true, "wolf": false }
var lessonsCompleted: Dictionary = {} 

#Set lesson, and state of the lesson
func setLessonCompleted(lesson:StringName, state: bool) -> void:
	lessonsCompleted[lesson] = state;
	lesson_completed.emit(lesson)
	return

#Given a lesson name, return the lessons status. If the lesson doesn't exist, return false
func isLessonCompleted(lesson: StringName) -> bool:
	return lessonsCompleted.get(lesson, false)

func saveData() -> void:
	var dir_path: String = "user://saves/"
	
	# Ensure the directory exists before attempting to write files into it
	if not DirAccess.dir_exists_absolute(dir_path):
		var err := DirAccess.make_dir_recursive_absolute(dir_path)
		if err != OK:
			push_error("Failed to create directory: %s (Error %d)" % [dir_path, err])
			return

	var fileName: String = dir_path + user + ".dat"
	var saveFile : FileAccess = FileAccess.open(fileName, FileAccess.WRITE)
	
	if not saveFile:
		push_error("Failed to save file")
	
	saveFile.store_var(lessonsCompleted)
	saveFile.close()
	
	var testOpen : FileAccess = FileAccess.open(fileName, FileAccess.READ)
	print(testOpen.get_var())

func createAIFolder() -> void:
	var dir_path: String = "user://generatedStories/"
	
	# Ensure the directory exists before attempting to write files into it
	if not DirAccess.dir_exists_absolute(dir_path):
		var err := DirAccess.make_dir_recursive_absolute(dir_path)
		if err != OK:
			push_error("Failed to create directory: %s (Error %d)" % [dir_path, err])
			return
