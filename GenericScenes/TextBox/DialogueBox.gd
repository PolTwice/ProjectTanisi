extends Resource
#Resource to hold all the audio and lines for a story
#resource will be used in "StoryBox.gd"  

class_name DialogBlock

@export var creeLines: Array[String] = []
@export var englishLines: Array[String] = []
@export var creeAudios: Array[AudioStream] = []
@export var englishAudios: Array[AudioStream] = []
