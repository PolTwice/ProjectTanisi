extends Control

@onready var page_one_picture: TextureRect = $PagesHBOX/PageOneMargin/PageOneVBox/PageOnePicture
@onready var page_two_picture: TextureRect = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoPicture

@onready var page_one_cree: RichTextLabel = $PagesHBOX/PageOneMargin/PageOneVBox/PageOneCree
@onready var page_one_english: RichTextLabel = $PagesHBOX/PageOneMargin/PageOneVBox/PageOneEnglish

@onready var page_two_cree: RichTextLabel = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoCree
@onready var page_two_english: RichTextLabel = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoEnglish


@onready var back: TextureButton = $PagesHBOX/PageOneMargin/PageOneVBox/Back
@onready var next: TextureButton = $PagesHBOX/PageTwoMargin/PageTwoVBox/Next

var bookContents 
#var creeLines: Array[String] = []
#var englishLines: Array[String] = []
#var creeAudios: Array[AudioStream] = []
#var englishAudios: Array[AudioStream] = []

signal bookNextSignal();
signal bookBackSignal();


var pageOnePicture
var pageTwoPicture

var creeLinesOne
var englishLinesOne

var creeLinesTwo
var englishLinesTwo

func _ready() -> void:
	
	bookContents  = get_parent().bookContents
	back.disabled=true;
	
	if(bookContents != null):
		updateFromResource()
	else:
		return;
		
func updateFromResource():
	for line in 
	creeLines = dialogueBox.creeLines
	englishLines = dialogueBox.englishLines
	creeAudios = dialogueBox.creeAudios
	englishAudios= dialogueBox.englishAudios
	

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
