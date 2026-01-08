extends CanvasLayer

@onready var contents_node: RichTextLabel = $TextPanel/TextMargin/Contents
@onready var background_image_node: TextureRect = $BackgroundImage
@onready var animated_sprite_node: AnimatedSprite2D = $AnimatedSprite
@onready var narration_node: AudioStreamPlayer = $Narration
@onready var background_sound_node: AudioStreamPlayer = $BackgroundSound
@onready var button_node: Button = $TextPanel/TextMargin/HBoxContainer/MarginContainer/Button


#Contents of the story
@export var StoryText: String

#The word that we are targeting in this line of the story
@export var EnglishTarget: String
@export var CreeTarget: String

#Texture of the background of the story
@export var backgroundTexture: Texture

#Frames for the animation:
@export var animation: SpriteFrames

func _on_ready() -> void:
	contents_node.text = highlightWords()
	if (backgroundTexture != null):
		background_image_node.texture = backgroundTexture
	else:
		showError()
	if (animation != null):
		animated_sprite_node.sprite_frames = animation
		
	var buttonText = EnglishTarget + "\n" + CreeTarget
	button_node.text = buttonText
	
#Highlight the words in the text label
func highlightWords() -> String:
	#Process the words and highlight the words appropriately
	
	#TEMP
	return StoryText

#Display some error
func showError() -> void:
	
	pass
