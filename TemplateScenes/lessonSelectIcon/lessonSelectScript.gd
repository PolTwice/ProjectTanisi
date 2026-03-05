class_name lessonIcon extends Area2D

#Sprite of the
@onready var lesson_sprite: AnimatedSprite2D = $lessonSprite

#audio stream that says the name of the lesson
@onready var lesson_name: AudioStreamPlayer = $lessonName

#audio stream that is a sound effect that
@onready var lesson_sound: AudioStreamPlayer = $lessonSound



#Holds next scene. String path is currently being used by scene manager
#@export var lessonScene: PackedScene			Stopped using in favor of using scene path
@export var lessonPath: String
@export var lessonName: String
@export var animation: SpriteFrames
@export var lessonSound: AudioStream
@export var lessonNameAudio: AudioStream


func _ready() -> void:
	lesson_sprite.sprite_frames = animation
	lesson_name.stream = lessonNameAudio
	lesson_sound.stream = lessonSound
	GlobalState.connect("lesson_completed",Callable(self,"_on_lesson_complete"))
	
func _on_mouse_entered() -> void:
	#lesson_sprite.play()
	pass
	
func _on_mouse_exited() -> void:
	#lesson_sprite.pause()
	pass
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		
		#play the sound of the lesson
		lesson_sound.play()
		
		#play animation
		lesson_sprite.play()

func _on_lesson_sound_finished() -> void:
	lesson_name.play()

func _on_lesson_name_finished() -> void:
	#pause then move the next scene
	GlobalState.sceneManager.changeNodeOne(lessonPath, lessonName)
