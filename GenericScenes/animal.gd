extends Area2D
#This script is linked to the genericAnimal Scene

@onready var animal_sprite: AnimatedSprite2D = $AnimalSprite

#Holds next scene. String path is currently being used by scene manager
#@export var lessonScene: PackedScene			Stopped using in favor of using scene path
@export var lessonPath: String
@export var lessonName: String

func _ready() -> void:
	GlobalState.connect("lesson_completed",Callable(self,"_on_lesson_complete"))
	pass
	
func _on_lesson_complete() -> void:
	#enter code here to make animal grayscale or marked complete
	pass
func _on_mouse_entered() -> void:
	animal_sprite.play()
	
func _on_mouse_exited() -> void:
	animal_sprite.pause()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		#pause
		#play animation
		#play sounds
		
		
		GlobalState.sceneManager.changeNodeOne(lessonPath, lessonName)
