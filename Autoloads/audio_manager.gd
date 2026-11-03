class_name AudioManager extends Node


@onready var stream_one: AudioStreamPlayer = $StreamOne
@onready var stream_two: AudioStreamPlayer = $StreamTwo
@onready var stream_three: AudioStreamPlayer = $StreamThree

var audioPlayers = [stream_one, stream_two, stream_three]

func _on_ready() -> void:
	GlobalState.AudioManager = self

# Takes stream path 
# returns audiostream if found
# returns null if error
func getStreamFromPath(streamPath: String) -> AudioStream:
	var audioStream = get_node(streamPath)
	if(!audioStream):
		push_error("Error in Audio Manager: Cannot convert path: ", streamPath," to stream.")
		audioStream = null
	return audioStream

# Takes an int or a audioStream player
# Return audio stream player
# Error returns null
func getPlayer(audioPlayer: Variant) -> AudioStreamPlayer:
	#if we get an audio stream player, return it right away
	if audioPlayer is AudioStreamPlayer:
		return audioPlayer as AudioStreamPlayer
		
	#if we get something that isnt an int, return null
	if !(audioPlayer is int):
		push_error("Error in Audio Manager: getPlayer() only takes an int or an AudioStreamPlayer")
		return null

	#if the int is more than the amount of audio players availabe or is 0 less, we return null
	if audioPlayer > audioPlayers.length() || audioPlayer < 1:
		push_error("Error in Audio Manager: getPlayer() number is ", audioPlayer)
		return null
	
	#subtract one to get index
	audioPlayer = audioPlayer - 1
	return audioPlayers[audioPlayer]

#Takes an audio player
#return if audio is playing. 
#error returns falls
func isPlaying(audioPlayer: Variant) -> bool:
	audioPlayer = getPlayer(audioPlayer)
	if audioPlayer == null:
		push_error("Error in Audio manager: isPlaying() is checking for a null audioPlayer")
		return false
	return audioPlayer.playing

# returns an audio stream player that is not currently playing. 
# if error, returns null
func findFree() -> AudioStreamPlayer:
	for player in audioPlayers:
		if !(isPlaying(player)):
			return player
	push_error("Error in Audio Manager: Could not find a free Audio Stream Player")
	return null
	
# play a sound
func playSound(soundPath: String)-> AudioStreamPlayer:
	var audioStream = getStreamFromPath(soundPath)
	
	if !audioStream:
		push_error("Error in Audio Manager: Could not play sound. Path ", soundPath, " could not be played")
		return null
		
	var audioPlayer = findFree()
	
	if !audioPlayer:
		push_error("Error in Audo Manager: Could not find free audio player to play sound.")
		return null
	
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
