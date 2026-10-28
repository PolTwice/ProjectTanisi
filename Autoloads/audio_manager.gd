class_name AudioManager extends Node

@onready var stream_one: AudioStreamPlayer = $StreamOne
@onready var stream_two: AudioStreamPlayer = $StreamTwo
@onready var stream_three: AudioStreamPlayer = $StreamThree

var audioPlayers = [stream_one, stream_two, stream_three]
enum sounds {}

func _on_ready() -> void:
	GlobalState.AudioManager = self

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
	audioPlayer = getPlayer(audioPlayer)
	if audioPlayer == null:
		push_error("Error in Audio manager: isPlaying() is checking for a null audioPlayer")
		return false

	return audioPlayer.playing
		
#find a free audio stream player, if not return null
func findFree() -> AudioStreamPlayer:
	for player in audioPlayers:
		if !(isPlaying(player)):
			return player
	return null
	
func playSound(soundPath: String)-> AudioStreamPlayer:
	var audioStream = getStreamFromPath(soundPath) as AudioStream
	if !audioStream:
		push_error("Error in Audio Manager: Path ", soundPath, " could not be played")
	var audioPlayer = findFree() as AudioStreamPlayer
	changeStream(audioPlayer, audioStream, true)
	audioPlayer.play()
	return audioPlayer
	
	
func changeStream(audioStreamPlayer: Variant, audioStream: AudioStream, checkPlaying: bool) -> AudioStreamPlayer:
	if checkPlaying == true && isPlaying(audioStreamPlayer):
		print("Cannot change stream. Check playing is true and ",audioStreamPlayer, " is playing ", audioStreamPlayer.stream)
		return null
	
	var desiredStreamPlayer = getPlayer(audioStreamPlayer) as AudioStreamPlayer
	
	if(!desiredStreamPlayer):
		push_error("Error in Audio Manager: Can't find audio stream player: ", audioStreamPlayer)
		return null
		
	if (!audioStream):
		push_error("Error in Audio Manager: Can't find audio stream: ", audioStream)
		return
		
	desiredStreamPlayer.stream = audioStream
	return desiredStreamPlayer

func playStreamPlayer(audioStreamPlayer: Variant):
	var audioPlayer = getPlayer(audioStreamPlayer) as AudioStreamPlayer
	if !audioPlayer:
		push_error("Error in Audio Manager: Can't play audio player ", audioPlayer)
	audioPlayer.play()
