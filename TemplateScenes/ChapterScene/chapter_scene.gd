extends CanvasLayer

@onready var info: Button = $HBoxContainer/MidMargin/PageInfoMargin/Info
@onready var transition_layer: CanvasLayer = $TransitionLayer
@onready var transition_color: ColorRect = $TransitionColor
@onready var button: Button = $Vbox/MarginContainer/Button

@export var infoText: String
var selection = {"LessonName": null, "LessonPath": null}

func _ready() -> void:
	TransitionManager.make_invisible(transition_color)
	SignalHub.lessonSelected.connect(_lesson_selected)
	print("Connected Signal")
	if(infoText != null):
		info.text = infoText

func _lesson_selected(lessonName: StringName, lessonPath: StringName) -> void:
	print("running function from chapter scene")
	selection[0] = lessonName
	selection[1] = lessonPath
	transition_color.visible = true
	TransitionManager.fade_in(transition_color,1.0,0.8)
	
	button.visible = true
	button.text = "Start the " + lessonName + " lesson"
	TransitionManager.fade_in(button)
	
func _on_transition_color_gui_input(event: InputEvent) -> void:
	var is_click = event is InputEventMouseButton and event.pressed
	var is_touch = event is InputEventScreenTouch and event.pressed
	
	if is_click or is_touch:
		selection = {"LessonName": null, "LessonPath": null}
		TransitionManager.fade_out(transition_color)
		TransitionManager.fade_out(button)
		SignalHub.selectOff.emit()


func _on_button_pressed() -> void:
	GlobalState.sceneManager.changeNodeOne(selection[1])
