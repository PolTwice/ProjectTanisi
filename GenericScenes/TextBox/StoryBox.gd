extends Control
#script for "StoryTextBox.tscn"
#needs resource "DialogueBox"

@onready var creeLabel: RichTextLabel = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/TextboxDesign/TextboxContainer/CreeContainer/Cree
@onready var englishLabel: RichTextLabel = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/TextboxDesign/TextboxContainer/EnglishContainer/English
@onready var cree_narration: AudioStreamPlayer = $CreeNarration
@onready var english_narration: AudioStreamPlayer = $EnglishNarration
@onready var listen_again: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/ListenAgainMarginContainer/ListenAgain
@onready var continueStory: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/ContinueMarginContainer/Continue
@onready var back: Button = $MarginContainer/BoxDesign/TextboxMargin/VBoxContainer/ButtonsContainer/BackMarginContainer/Back

#get the resource from the parent
var dialogueBox 
#var creeLines: Array[String] = []
#var englishLines: Array[String] = []
#var creeAudios: Array[AudioStream] = []
#var englishAudios: Array[AudioStream] = []

signal storyNextSignal();
signal storyBackSignal();

var creeLines
var englishLines 
var creeAudios 
var englishAudios

func _ready() -> void:
	
	dialogueBox = get_parent().storyResource
	
	listen_again.disabled = true
	back.disabled=true;
	
	if(dialogueBox != null):
		updateFromResource()
	else:
		return;
		
func updateFromResource():
	creeLines = dialogueBox.creeLines
	englishLines = dialogueBox.englishLines
	creeAudios = dialogueBox.creeAudios
	englishAudios= dialogueBox.englishAudios
	

	
	cree_narration.connect("finished",Callable(self, "_on_cree_audio_finished"))
	english_narration.connect("finished",Callable(self,"_on_english_audio_finished"))
	
func show_line(index: int):
	back.disabled=true;
	
	if(dialogueBox == null):
		print("No resource loaded")
		return
		
	if (index >= creeLines.size()):
		print("End of dialogue")
		return
		
	creeLabel.text = creeLines[index]
	englishLabel.text = englishLines[index]
	cree_narration.stream = creeAudios[index]
	english_narration.stream = englishAudios[index]
	continueStory.disabled = true;
	playCreeAudio()

#Disable the listen again button, the start playing the cree narration
func playCreeAudio():
	listen_again.disabled = true;
	cree_narration.play()

#after the cree audio is finished, play the english audio
func _on_cree_audio_finished():
	english_narration.play()

#after the english audio is finished, re enable the listen-again button.
func _on_english_audio_finished():
	listen_again.disabled = false
	continueStory.disabled = false
	if(get_parent().storyIndex>0):
		back.disabled=false

func _on_back_pressed() -> void:
	emit_signal("storyBackSignal")
	print("Story back signal sent")
	pass

func _on_listen_again_pressed() -> void:
	listen_again.disabled = false
	continueStory.disabled = false
	playCreeAudio()

func _on_continue_pressed() -> void:
	emit_signal("storyNextSignal")
	print("Story next signal sent")
