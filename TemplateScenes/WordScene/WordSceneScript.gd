extends CanvasLayer

@onready var animated_sprite_2d_node: AnimatedSprite2D = $AnimatedSprite2D
@onready var english_reading_node: AudioStreamPlayer = $HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord/EnglishReading
@onready var cree_reading_node: AudioStreamPlayer = $HBoxContainer/CreeVBox/CreeMargin/CreeWord/CreeReading
@onready var english_word_node: Button = $HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord
@onready var cree_word_node: Button = $HBoxContainer/CreeVBox/CreeMargin/CreeWord
@onready var background_node: TextureRect = $Background
@onready var narration: RichTextLabel = $Narration
@onready var narration_audio: AudioStreamPlayer = $NarrationAudio

##EXPORTS
@export var background: Texture
@export var spriteFrames: SpriteFrames
@export var EnglishButtonText: String
@export var CreeButtonText: String
@export var englishReading: AudioStream
@export var creeReading: AudioStream
@export var Reading: AudioStream

signal canContinue

func _on_english_word_pressed() -> void:
	english_reading_node.play()

func _on_cree_word_pressed() -> void:
	cree_reading_node.play()


func _on_ready() -> void:
	narration.text = EnglishButtonText +" in Cree is " + CreeButtonText
	english_word_node.text = EnglishButtonText
	cree_word_node.text = CreeButtonText
	english_reading_node.stream = englishReading
	cree_reading_node.stream = creeReading
	background_node.texture = background
	narration_audio.stream = Reading
	
	narration_audio.play()
	
