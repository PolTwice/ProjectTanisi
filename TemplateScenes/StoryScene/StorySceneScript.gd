extends CanvasLayer

@onready var contents_node: RichTextLabel = $TextPanel/TextMargin/HBoxContainer/Contents
@onready var background_image_node: TextureRect = $BackgroundImage
@onready var animated_sprite_node: AnimatedSprite2D = $AnimatedSprite
@onready var narration_node: AudioStreamPlayer = $Narration
@onready var background_sound_node: AudioStreamPlayer = $BackgroundSound
@onready var button_node: Button = $TextPanel/TextMargin/HBoxContainer/MarginContainer/Button
@onready var margin_container: MarginContainer = $TextPanel/TextMargin/HBoxContainer/MarginContainer


#Contents of the story
@export var StoryText: String

#The word that we are targeting in this line of the story
@export var EnglishTarget: String
@export var switchButtonEnabled: bool = true
@export var CreeTarget: String

#Texture of the background of the story
@export var backgroundTexture: Texture

#Frames for the animation:
@export var animation: SpriteFrames

@export var EnglishNarration: AudioStream
@export var CreeNarration: AudioStream

var isEnglish = true
var firstPush = true

signal canContinue

func _on_ready() -> void:
	#if has switch, then we r
	if(switchButtonEnabled):
		StoryText = StoryText.replace(EnglishTarget, "[color=#FFD000]"+EnglishTarget+"[/color]")
	else:
		margin_container.visible = false
		
	contents_node.text = StoryText
	print("Text replaced")
	
	if (backgroundTexture != null):
		background_image_node.texture = backgroundTexture
	else:
		showError()
	animated_sprite_node.play()
	button_node.text = EnglishTarget + "\n🔄\n" + CreeTarget
	
	narration_node.stream = EnglishNarration
	

	await get_tree().create_timer(1.0).timeout
	narration_node.play()
	
#Display some error
func showError() -> void:
	self.visible = false
	pass

func _on_button_pressed() -> void:
	if(firstPush):
		canContinue.emit()
		firstPush = false
	if(isEnglish):
		#check if target is there
		if !StoryText.find(EnglishTarget):
			print("Word not found in story text")
			showError()
		#replace
		StoryText = StoryText.replace(EnglishTarget, CreeTarget)
		narration_node.stream = CreeNarration
	#if it is currently on cree, swap to english
	else:
		#check if target is there
		if !StoryText.find(CreeTarget):
			print("Word not found in story text")
			showError()
		#replace
		StoryText = StoryText.replace(CreeTarget, EnglishTarget)
		narration_node.stream = EnglishNarration
	#swap mode the cree mode
	isEnglish = !isEnglish
	#Change the text to display correctly
	contents_node.text = StoryText
	button_node.disabled = true
	narration_node.play()


func _on_narration_finished() -> void:
	if(!switchButtonEnabled):
		canContinue.emit()
	button_node.disabled= false
