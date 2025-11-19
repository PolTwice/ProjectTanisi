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
#@export var creeLines: Array[String] = []
#@export var englishLines: Array[String] = []
#@export var pictures: Array[Texture] = []

signal bookNextSignal();
signal bookBackSignal();


var pageOnePicture: Array[Texture]
var pageTwoPicture: Array[Texture]

var creeLinesOne: Array[String]
var englishLinesOne: Array[String]

var creeLinesTwo: Array[String]
var englishLinesTwo: Array[String]

func _ready() -> void:
	
	bookContents  = get_parent().bookContents
	back.disabled=true;
	
	if(bookContents != null):
		updateFromResource()
	else:
		return;
		
func updateFromResource():
	var counter = 1 
	for line in bookContents.creeLines:
		if counter % 2 !=0:
			creeLinesOne.append(line)
		else:
			creeLinesTwo.append(line)
		counter +=1
		
	counter = 1 
	for line in bookContents.englishLines:
		if counter % 2 !=0:
			englishLinesOne.append(line)
		else:
			englishLinesTwo.append(line)
		counter +=1
	
	counter = 1 
	for pic in bookContents.pictures:
		if counter % 2 !=0:
			pageOnePicture.append(pic)
		else:
			pageTwoPicture.append(pic)
		counter +=1

func show_line(index: int):
	back.disabled=true;
	
	if(bookContents == null):
		print("No resource loaded")
		return
		
	if index >= ( creeLinesOne.size()+creeLinesTwo.size() ):
		print("End of dialogue")
		return
		
	page_one_cree.text = creeLinesOne[index]
	page_one_english.text = englishLinesOne[index]
	page_one_picture.texture = pageOnePicture[index]
	
	page_two_cree.text = creeLinesTwo[index]
	page_two_english.text = englishLinesTwo[index]
	page_two_picture.texture = pageTwoPicture[index]

func _on_back_pressed() -> void:
	emit_signal("storyBackSignal")
	print("Story back signal sent")
	pass

func _on_continue_pressed() -> void:
	emit_signal("storyNextSignal")
	print("Story next signal sent")
