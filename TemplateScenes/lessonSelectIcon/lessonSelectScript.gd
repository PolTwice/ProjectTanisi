class_name lessonIcon extends Area2D

#Sprite of the lesson select Icon
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
	#set the sprite to the one specified in the export
	lesson_sprite.sprite_frames = animation
	#set the lesson name stream to the one specified in the export
	lesson_name.stream = lessonNameAudio
	#set the sound stream to the one specified in the export
	lesson_sound.stream = lessonSound
	
	#connect the lesson completed signal
	#(this doesn't seem necessary?
	#instead this should read if it is complete from the global state
	GlobalState.connect("lesson_completed",Callable(self,"_on_lesson_complete"))

#change this to be more appropriate
func _on_mouse_entered() -> void:
	#make it bigger when you hover over it.
	pass
	
func _on_mouse_exited() -> void:
	#make it smaller
	pass
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#this checks for an event, and checks if the vent is either a click or a press from a touch screen.
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		
		#play the sound of the lesson
		#after this, we go to _on_lesson_sound_finished() function
		lesson_sound.play() 
		
		#play animation
		lesson_sprite.play()

func _on_lesson_sound_finished() -> void:
	#when the lesson sound is finished, play the name of the lesson
	lesson_name.play()

func _on_lesson_name_finished() -> void:
	#When the lesson name is finished, move to the lesson
	GlobalState.sceneManager.changeNodeOne(lessonPath, lessonName)
