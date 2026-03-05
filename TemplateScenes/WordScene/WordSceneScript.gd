extends CanvasLayer

@onready var animated_sprite_2d_node: AnimatedSprite2D = $AnimatedSprite2D
@onready var english_reading: AudioStreamPlayer = $VBoxContainer/HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord/EnglishReading
@onready var english_word: Button = $VBoxContainer/HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord
@onready var background_node: TextureRect = $Background
@onready var narration: RichTextLabel = $VBoxContainer/Narration
@onready var narration_audio: AudioStreamPlayer = $NarrationAudio
@onready var cree_reading: AudioStreamPlayer = $VBoxContainer/HBoxContainer/CreeVBox/CreeMargin/CreeWord/CreeReading
@onready var cree_word: Button = $VBoxContainer/HBoxContainer/CreeVBox/CreeMargin/CreeWord

##EXPORTS
@export var background: Texture
@export var spriteFrames: SpriteFrames
@export var EnglishButtonText: String
@export var CreeButtonText: String
@export var englishReading: AudioStream
@export var creeReading: AudioStream
@export var Reading: AudioStream

signal canContinue
var engDone: bool = false
var creeDone: bool = false

func _on_english_word_pressed() -> void:
	english_reading.play()

func _on_cree_word_pressed() -> void:
	cree_reading.play()


func _on_ready() -> void:
	narration.text = EnglishButtonText +" in Cree is " + CreeButtonText
	english_word.text = EnglishButtonText
	cree_word.text = CreeButtonText
	english_reading.stream = englishReading
	cree_reading.stream = creeReading
	background_node.texture = background
	narration_audio.stream = Reading
	
	narration_audio.play()

func _on_english_reading_finished() -> void:
	engDone = true
	checkCanContinue()

func _on_cree_reading_finished() -> void:
	creeDone = true
	checkCanContinue()

func checkCanContinue() -> void:
	if(engDone && creeDone):
		canContinue.emit()
	
