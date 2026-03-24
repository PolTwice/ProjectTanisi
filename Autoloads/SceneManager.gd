class_name SceneManager extends CanvasLayer
#linked to root node. Methods will be used for changing scenes.
#this script is an autoload as well

@onready var ui: MainUI = $CanvasLayer/UI
@onready var nodeContainerOne: Node = $NodeContainerOne
@onready var color_rect: ColorRect = $TransitionLayer/ColorRect


#an array holds the paths of the last scenes
var backStack = [];
#an array that holds the names of the last scenes
var nameHistory = []


var currentContainerOne;
var currentContainerOnePath;

func _ready() -> void:
	currentContainerOne = $NodeContainerOne/AnimalSelectScene
	currentContainerOnePath = "res://ChapterOne/AnimalSelectScenes/animalSelectScene.tscn"
	
#Used to change the scene contained in NodeContainerOne
func changeNodeOne (new_scene: String, pushToStack = true, fade = true, fadeTime = 1.0):
	
	#if we want to add the scene to the backstack.	
	if(pushToStack):
		backStack.append(currentContainerOnePath)
		ui.back.disabled = false;
	
	if currentContainerOne != null:
		currentContainerOne.queue_free()
	if fade:
		await TransitionManager.fade_in(color_rect,fadeTime).finished
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
	
	if fade:
		await TransitionManager.fade_out(color_rect).finished

func backNodeOne() -> void:
	var backScene = backStack.pop_back()
	if(backScene != null):
		changeNodeOne(backScene,false)

func _enter_tree() -> void:
	GlobalState.sceneManager = self;
