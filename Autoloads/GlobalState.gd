extends Node
#autoload singleton for storing global variables and references

#Declare and create the SceneManager so it is accessible. 
var sceneManager: SceneManager

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
