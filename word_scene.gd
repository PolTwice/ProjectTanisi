extends CanvasLayer

@onready var animated_sprite_2d_node: AnimatedSprite2D = $AnimatedSprite2D
@onready var narration_node: AudioStreamPlayer = $Narration
@onready var english_reading_node: AudioStreamPlayer = $HBoxContainer/EnglishVBox/EnglishMargin/EnglishWord/EnglishReading
@onready var cree_reading_node: AudioStreamPlayer = $HBoxContainer/CreeVBox/CreeMargin/CreeWord/CreeReading

@export var spriteFrames: SpriteFrames



func _on_english_word_pressed() -> void:
	pass # Replace with function body.


func _on_cree_word_pressed() -> void:
	pass # Replace with function body.



func _on_ready() -> void:
	pass # Replace with function body.
