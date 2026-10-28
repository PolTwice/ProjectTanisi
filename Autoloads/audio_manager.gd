class_name AudioManager extends Node

@onready var stream_one: AudioStreamPlayer = $StreamOne
@onready var stream_two: AudioStreamPlayer = $StreamTwo
@onready var stream_three: AudioStreamPlayer = $StreamThree

var audioPlayers = [stream_one, stream_two, stream_three]
enum sounds {}

func _on_ready() -> void:
	GlobalState.audioManager = self

func getStreamFromPath(streamPath: String) -> AudioStream:
	var audioStream = get_node(streamPath)
	if(!audioStream):
		push_error("Error in Audio Manager: Cannot convert path: ", streamPath," to stream.")
		audioStream = null
	return audioStream

#Takes an int most of the time but also take AudioStreamPlayer
func getPlayer(audioPlayer: Variant) -> AudioStreamPlayer:
	#if we get an audio stream player, return it right away
	if audioPlayer is AudioStreamPlayer:
		return audioPlayer as AudioStreamPlayer
		
	#if we get something that isnt an int, return null
	if !(audioPlayer is int):
		push_error("Error in Audio Manager: getPlayer() only takes an int or an AudioStreamPlayer")
		return null
	
	#
	var desiredStreamPlayer : AudioStreamPlayer
	match audioPlayer:
		1:
			desiredStreamPlayer = stream_one
		2:
			desiredStreamPlayer = stream_two
		3:
			desiredStreamPlayer = stream_three
		_:
			push_error("Error in Audio Manager: Invalid stream player number: ", audioPlayer)
			return null
	return desiredStreamPlayer

#Can take either a stream or a number. 
func isPlaying(audioPlayer: Variant) -> bool:
	audioPlayer = 
			
	if !(audioPlayer is AudioStreamPlayer):
		push_error("Error in Audio Manager: Can't check if ", typeof(audioPlayer), " is playing.")
		return false

	return audioPlayer.playing
		
#find a free audio stream player, if not return null
func findFree() -> AudioStreamPlayer:
	for player in audioPlayers:
		if !(isPlaying(player)):
			return player
	return null
	
	
func changeStream(audioPlayerNum: int, audioStream: AudioStream, checkPlaying: bool) -> AudioStreamPlayer:
	var desiredStreamPlayer = getPlayer(audioPlayerNum)
	
	if(!desiredStreamPlayer):
		push_error("Error in Audio Manager: Can't find audio stream player: ", audioPlayerNum)
		return
		
	if (!audioStream):
		push_error("Error in Audio Manager: Can't find audio stream: ", audioStream)
		return
		
	desiredStreamPlayer.stream = audioStream

func playStream(audioPlayerNum: int) -> void:
	var streamPlayer = numToPlayer(audioPlayerNum)
	if(!streamPlayer):
		print("Error trying to play AudioStreamPlayer:", audioPlayerNum)
		return
	streamPlayer.play()
