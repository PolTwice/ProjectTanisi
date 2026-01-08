extends CanvasLayer

@onready var animated_sprite_2d_node: AnimatedSprite2D = $AnimatedSprite2D
@onready var narration_node: AudioStreamPlayer = $Narration
@onready var english_reading_node: AudioStreamPlayer = $HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord/EnglishReading
@onready var cree_reading_node: AudioStreamPlayer = $HBoxContainer/CreeVBox/CreeMargin/CreeWord/CreeReading
@onready var english_word_node: Button = $HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord
@onready var cree_word_node: Button = $HBoxContainer/CreeVBox/CreeMargin/CreeWord
@onready var background_node: TextureRect = $Background

@export var background: Texture
@export var spriteFrames: SpriteFrames
@export var EnglishButton: String
@export var CreeButton: String
@export var englishReading: AudioStream
@export var creeReading: AudioStream


func _on_english_word_pressed() -> void:
	english_reading_node.play()


func _on_cree_word_pressed() -> void:
	cree_reading_node.play()

func _on_ready() -> void:
	english_word_node.text = EnglishButton
	cree_word_node.text = CreeButton
	english_reading_node.stream = englishReading
	cree_reading_node.stream = creeReading
	background_node.texture = background
	
