extends Control

@onready var background: TextureRect = $Background
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite

@onready var background_sound: AudioStreamPlayer = $BackgroundSound
@onready var random_interval_sound: AudioStreamPlayer = $randomIntervalSound
@onready var random_interval_sound_2: AudioStreamPlayer = $randomIntervalSound2

#placeholder silence sound
const SILENCE = preload("uid://cd41sp1tnxguk")

var animation: Resource
#@export var backgrounds: Array[Texture] = []
#@export var animations: Array[SpriteFrames] = []
#@export var backgroundSounds: Array[AudioStream] = []
#@export var randomSounds: Array[AudioStream] = []
#@export var randomSounds2: Array[AudioStream] = []

#array of background sounds
var backgroundArray
var animationArray

var backgroundSoundArray = []
var randomIntervalSoundArray = []
var randomIntervalSound2Array = []

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

	# Background sounds
	if animation.backgroundSounds.is_empty():
		backgroundSoundArray.resize(backgroundArray.size())
		for i in backgroundSoundArray.size():
			backgroundSoundArray[i] = SILENCE
	else:
		backgroundSoundArray = animation.backgroundSounds
		
	# Random sound set 1
	if animation.randomSounds.is_empty():
		randomIntervalSoundArray = []
		randomIntervalSoundArray.resize(backgroundArray.size())
		for i in randomIntervalSoundArray.size():
			randomIntervalSoundArray[i] = SILENCE
	else:
		randomIntervalSoundArray = animation.randomSounds

	# Random sound set 2
	if animation.randomSounds2.is_empty():
		randomIntervalSound2Array = []
		randomIntervalSound2Array.resize(backgroundArray.size())
		for i in randomIntervalSound2Array.size():
			randomIntervalSound2Array[i] = SILENCE
	else:
		randomIntervalSound2Array = animation.randomSounds2

func show_animation(i):
	if i < backgroundArray.size():
		background.texture = backgroundArray[i]
		animated_sprite.sprite_frames = animationArray[i]
		animated_sprite.play("default");
		background_sound.stream = backgroundSoundArray[i]
		random_interval_sound.stream = randomIntervalSoundArray[i]
		random_interval_sound_2.stream = randomIntervalSound2Array[i]
	else:
		pass

var min_delay: float = 1.0
var max_delay: float = 4.0

func schedule_sound() -> void:
	_schedule_sound_1()
	_schedule_sound_2()

func _schedule_sound_1():
	var delay := randf_range(min_delay, max_delay)
	get_tree().create_timer(delay).timeout.connect(_play_and_reschedule)

func _schedule_sound_2():
	var delay := randf_range(min_delay, max_delay)
	get_tree().create_timer(delay).timeout.connect(_play_and_reschedule2)

func _play_and_reschedule() -> void:
	random_interval_sound.play()
	_schedule_sound_1()

func _play_and_reschedule2() -> void:
	random_interval_sound_2.play()
	_schedule_sound_2()
