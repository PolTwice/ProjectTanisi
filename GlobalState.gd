extends Node
#autoload singleton for storing global variables and references

#Declare and create the SceneManager so it is accessible. 
var sceneManager: SceneManager

#signal for lesson and quiz completion
signal lesson_completed(lesson_id: StringName)
signal quiz_completed(quiz_id: StringName, score:int, total:int)

# Holds lessons and whether they’re complete
# Example: { "beaver": true, "wolf": false }
var lessonsCompleted: Dictionary = {} 

# Holds quizzes as keys, each value is {"score": int, "total": int}
# Example: { "beaverQuiz": {"score": 3, "total": 5} }"
var quizScores: Dictionary = {}

#Set lesson, and state of the lesson
func setLessonCompleted(lesson:StringName, state: bool) -> void:
	lessonsCompleted[lesson] = state;
	lesson_completed.emit(lesson)
	
	return

#Given a lesson name, return the lessons status. If the lesson doesn't exist, return false
func isLessonCompleted(lesson: StringName) -> bool:
	return lessonsCompleted.get(lesson, false)

#set Quiz, quiz score, and total points
func setQuizScore(quiz: StringName, score: int, total: int) -> void:
	quizScores[quiz] = {"score": score, "total": total}
	quiz_completed.emit(quiz, score, total)
	
#Given a quiz, return a dictionary with the score, and total. if no quiz exists, return -1 for both
func getQuizScore(quiz: StringName) -> Dictionary:
	#returns the quiz score and total in a dictionary. First is score, then quiz. if quiz does not exist, return -1 for both. 
	return quizScores.get(quiz,{"score": -1, "total": -1})
