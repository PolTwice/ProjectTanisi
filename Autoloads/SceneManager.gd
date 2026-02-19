class_name SceneManager extends CanvasLayer
#linked to root node. Methods will be used for changing scenes.

@onready var ui: MainUI = $UI

@export var nodeContainerOne: Node

#an array holds the paths of the last scenes
var backStack = [];
#an array that holds the names of the last scenes
var nameHistory = []


var currentContainerOne;
var currentContainerOnePath;
var currentContainerName;

func _ready() -> void:
	GlobalState.sceneManager = self;
	
	#Make sure to change this in the future when the initial screen changes. 
	currentContainerOne = $NodeContainerOne/AnimalSelectScene
	currentContainerOnePath = "res://ChapterOne/AnimalSelectScenes/animalSelectScene.tscn"
	currentContainerName = "Pick an Animal to hear a Story!"
	ui.info.text = currentContainerName
	
#Used to change the scene contained in NodeContainerOne
func changeNodeOne (new_scene: String, infoText: String,pushToStack = true, delete: bool = true, keep_running: bool = false):
	
	#if we want to add the scene to the backstack.	
	if(pushToStack):
		backStack.append(currentContainerOnePath)
		ui.back.disabled = false;
		nameHistory.append(currentContainerName)
		#nameHistory.append(infoText)
	
	if currentContainerOne != null:
		if delete:	#if delete is true, delete the scene
			currentContainerOne.queue_free()
		elif keep_running:	#if true, the scene will continue to run in the background, but be invisible
			currentContainerOne.visible = false
		else:	#otherwise, remove the child from the tree and it sticks around in memory.
			nodeContainerOne.remove_child(currentContainerOne)
	
	#instantiate the new scene
	var new = load(new_scene).instantiate()
	#make new scene a child of nodeContainerOne
	nodeContainerOne.add_child(new)
	
	#disable the button if there is nothing in the back stack
	if(backStack.is_empty()):
		ui.back.disabled = true;
	
	#update currentContainer variables
	currentContainerOne = new
	currentContainerOnePath = new_scene
	changeInfoUi(infoText)

func backNodeOne() -> void:
	var backScene = backStack.pop_back()
	if(backScene != null):
		changeNodeOne(backScene, nameHistory.pop_back(),false)
	
func changeInfoUi(infoText: String) -> void:
	ui.info.text = infoText;
