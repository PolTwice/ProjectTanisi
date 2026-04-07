class_name lessonIcon extends Area2D
#Sprite of the lesson select Icon
@onready var lesson_sprite: AnimatedSprite2D = $lessonSprite

#audio stream that says the name of the lesson
#@onready var lesson_name: AudioStreamPlayer = $lessonName

#audio stream that is a sound effect that
#@onready var lesson_sound: AudioStreamPlayer = $lessonSound

#How much the sprites grow and shring when hovered over.
@onready var scaleFactor = 1.5


#Holds next scene. String path is currently being used by scene manager
#@export var lessonScene: PackedScene			Stopped using in favor of using scene path
@export var lessonPath: StringName
@export var lessonName: StringName
@export var lessonSound: AudioStream
@export var lessonNameAudio: AudioStream

func _ready() -> void:
	#set the lesson name stream to the one specified in the export
	#if (lessonName != null):
		#lesson_name.stream = lessonNameAudio
	#set the sound stream to the one specified in the export
	#if (lessonSound != null):
		#lesson_sound.stream = lessonSound
	SignalHub.selectOff.connect(_select_off)
	#connect the lesson completed signal
	#(this doesn't seem necessary?
	#instead this should read if it is complete from the global state
	GlobalState.connect("lesson_completed",Callable(self,"_on_lesson_complete"))

#change this to be more appropriate
func _on_mouse_entered() -> void:
	lesson_sprite.scale *= scaleFactor
	lesson_sprite.play()
	pass
	
func _on_mouse_exited() -> void:
	lesson_sprite.pause()
	lesson_sprite.scale /= scaleFactor
	pass
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#this checks for an event, and checks if the vent is either a click or a press from a touch screen.
	if ((event is InputEventMouseButton and event.pressed)||(event is InputEventScreenTouch and event.pressed)):
		
		self.z_index = 10
		SignalHub.lessonSelected.emit(lessonName, lessonPath)
		
func _select_off() -> void:
	self.z_index = 0
