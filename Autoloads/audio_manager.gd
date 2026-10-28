class_name AudioManager extends Node

@onready var stream_one: AudioStreamPlayer = $StreamOne
@onready var stream_two: AudioStreamPlayer = $StreamTwo
@onready var stream_three: AudioStreamPlayer = $StreamThree

enum sounds {}

func _on_ready() -> void:
	GlobalState.audioManager = self

func pathToAudioStream(streamPath: String) -> AudioStream:
	var audioStream = get_node(streamPath)
	if(!audioStream):
		push_error("Error in Audio Manager: Cannot convert path: ", streamPath," to stream.")
		audioStream = null
	return audioStream

func numToPlayer(audioPlayerNum: int) -> AudioStreamPlayer:
	var desiredStreamPlayer : AudioStreamPlayer
	match audioPlayerNum:
		1:
			desiredStreamPlayer = stream_one
		2:
			desiredStreamPlayer = stream_two
		3:
			desiredStreamPlayer = stream_three
		_:
			push_error("Error in Audio Manager: Invalid stream player number: ", audioPlayerNum)
			return null
	return desiredStreamPlayer

func changeStream(audioPlayerNum: int, streamPath: String) -> void:
	var desiredStreamPlayer = numToPlayer(audioPlayerNum)
	
	if(!desiredStreamPlayer):
		print("Error finding audio stream player: ", audioPlayerNum)
		return
		
	var audioStream = pathToAudioStream(streamPath)
	if (!audioStream):
		print("Error finding audio stream: ", streamPath)
		return
		
	desiredStreamPlayer.stream = audioStream

func playStream(audioPlayerNum: int) -> void:
	var streamPlayer = numToPlayer(audioPlayerNum)
	if(!streamPlayer):
		print("Error trying to play AudioStreamPlayer:", audioPlayerNum)
		return
	streamPlayer.play()
