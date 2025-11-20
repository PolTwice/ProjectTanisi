extends Control

@export var bookResource: bookContentResource

@onready var page_one_picture: TextureRect = $PagesHBOX/PageOneMargin/PageOneVBox/PageOnePicture
@onready var page_two_picture: TextureRect = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoPicture

@onready var page_one_cree: RichTextLabel = $PagesHBOX/PageOneMargin/PageOneVBox/PageOneCree
@onready var page_one_english: RichTextLabel = $PagesHBOX/PageOneMargin/PageOneVBox/PageOneEnglish

@onready var page_two_cree: RichTextLabel = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoCree
@onready var page_two_english: RichTextLabel = $PagesHBOX/PageTwoMargin/PageTwoVBox/PageTwoEnglish


@onready var back: TextureButton = $PagesHBOX/PageOneMargin/PageOneVBox/Back
@onready var next: TextureButton = $PagesHBOX/PageTwoMargin/PageTwoVBox/Next

@onready var no_resource_error: RichTextLabel = $"../NoResourceError"
@onready var resoure_error: RichTextLabel = $"../ResoureError"

const SQUARE = preload("uid://dj8620tornxsa")
const STAR = preload("uid://dc4hjivllkw0x")

var bookContents 
#@export var creeLines: Array[String] = []
#@export var englishLines: Array[String] = []
#@export var pictures: Array[Texture] = []

var i = 0
var max_index 

var pageOnePicture: Array[Texture] = []
var pageTwoPicture: Array[Texture] = []

var creeLinesOne: Array[String] = []
var englishLinesOne: Array[String] = []

var creeLinesTwo: Array[String] = []
var englishLinesTwo: Array[String] = []

func _ready() -> void:
	
	#make the book contents = to book Resource
	bookContents  = bookResource
	
	#disable back at the beginning
	back.disabled=true;
	
	#if we have a resource, update from the resource, and show the first line
	if(bookContents != null):
		await updateFromResource()
		await show_line(i)
		
	#if no resource is loaded, display 
	else:
		#hide the book
		#display the error message if no resource is load
		visible = false

		no_resource_error.visible = true;
		return;

#populate arrays from the resource
func updateFromResource():
	var counter = 1 
	#odd numbered pages go on the left page, even goes on the right page
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
	
	#if the arrays are not equal size, display an error
	if englishLinesOne.size() != creeLinesOne.size() || englishLinesTwo.size() != creeLinesTwo.size():
		resoure_error.visible = true;
		
	#The Size one index index should
	max_index = creeLinesOne.size() - 1

func show_line(idx: int):
	if bookContents == null:
		print("No resource loaded")
		return
		
	var index = clamp(idx, 0, max_index)
	
	back.disabled = (index == 0)
	#next.disabled = (index == max_index)

	page_one_cree.text = creeLinesOne[index]
	page_one_english.text = englishLinesOne[index]
	
	#check if there is a picture, if not, use a default picture
	if pageOnePicture.size() == 0:
		page_one_picture.texture = SQUARE
	else:
		page_one_picture.texture = pageOnePicture[index]
	
	if index < creeLinesTwo.size():
		page_two_cree.visible = true
		page_two_english.visible = true
		page_two_picture.visible = true
		page_two_cree.text = creeLinesTwo[index]
		page_two_english.text = englishLinesTwo[index]
		
		if pageTwoPicture.size() == 0:
			page_two_picture.texture = STAR
		else:
			page_two_picture.texture = pageTwoPicture[index]
			
	else:
		page_two_cree.visible = true
		page_two_english.visible = false
		page_two_picture.visible = false
		page_two_cree.text = "The End"
		page_two_english.text = ""
		page_two_picture.texture = null

func _on_back_pressed() -> void:
	i = i-1
	show_line(i)

func _on_next_pressed() -> void:
	if i >= max_index:
		emit_signal("book_finished")
		print("book finished")
		return
		
	i = i+1
	show_line(i)
	
