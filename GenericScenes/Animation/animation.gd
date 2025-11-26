extends Control

@onready var background: TextureRect = $Background
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

@onready var background_sound: AudioStreamPlayer = $BackgroundSound
@onready var random_interval_sound: AudioStreamPlayer = $randomIntervalSound
@onready var random_interval_sound_2: AudioStreamPlayer = $randomIntervalSound2

const SILENCE = preload("uid://cd41sp1tnxguk")

@onready var index = 0;

var animation: Resource
#@export var backgrounds: Array[Texture] = []
#@export var animations: Array[SpriteFrames] = []
#@export var backgroundSounds: Array[AudioStream] = []
#@export var randomSounds: Array[AudioStream] = []
#@export var randomSounds2: Array[AudioStream] = []

var backgroundArray
var animationArray



func _ready() -> void:
	animation = get_parent().animationResource
	if(animation == null):
		pass
		#do something
	else:
		updateFromResource()
	schedule_sound()
	
func updateFromResource():
	backgroundArray = animation.backgrounds
	animationArray = animation.animations
	if background_sound == null:
		background_sound.stream = SILENCE
		random_interval_sound.stream = SILENCE
		random_interval_sound_2.stream = SILENCE
	
func show_animation(i):
	if i < backgroundArray.size():
		background.texture = backgroundArray[i]
		animated_sprite.sprite_frames = animationArray[i]
		animated_sprite.play("default");
	else:
		pass

var min_delay: float = 1.0
var max_delay: float = 4.0

func schedule_sound() -> void:
	var delay := randf_range(min_delay, max_delay)
	var delay2 := randf_range(min_delay, max_delay)
	get_tree().create_timer(delay).timeout.connect(_play_and_reschedule)
	get_tree().create_timer(delay2).timeout.connect(_play_and_reschedule2)

func _play_and_reschedule() -> void:
	random_interval_sound.play()
	schedule_sound()
	
func _play_and_reschedule2() -> void:
	random_interval_sound_2.play()
