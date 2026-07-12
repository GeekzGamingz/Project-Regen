@icon("uid://bg2lm15tg20gg")
class_name SteamVoice
extends Node
## Steam Voice custom node for using voice chat.
##
## A custom Node used to send and receive voice chat using Steam's voice functionality.
##
## @tutorial(GodotSteamKit voice tutorial): https://godotsteam.com/tutorials/godotsteamkit/voice

## Set as the default sample rate. Steam Voice only uses a range of 11025 to 48000; do not set this
## outside of that range if you change it.
const SAMPLE_RATE: int = 48000

## Whether the local player can hear themselves or not.  This should not be used in-game.
@export var use_loopback: bool = false
## Whether to use Steam's suggested optimal sample rate or not.  This will set it to whatever
## [method Steam.getVoiceOptimalSampleRate] returns.
@export var use_optimal_sample_rate: bool = false :
	set = _set_optimal_sample_rate

var _current_sample_rate: int = SAMPLE_RATE
var _voice_playback: AudioStreamGeneratorPlayback = null


func _ready() -> void:
	_setup_stream()


# If using GodotSteam versions 4.16 - 4.18.1, you will not have the getAvailableVoice() function so
# we skip that and go straight to getting the voice data.
func _process(_delta: float) -> void:
	if Steam.has_method("getAvailableVoice"):
		_check_for_voice()
	else:
		_get_voice_data()


#region Setup
func _setup_stream() -> void:
	var voice_stream_player := AudioStreamPlayer.new()
	add_child(voice_stream_player)
	voice_stream_player.stream = AudioStreamGenerator.new()
	voice_stream_player.stream.mix_rate = _current_sample_rate
	voice_stream_player.play()
	_voice_playback = voice_stream_player.get_stream_playback()
#endregion


#region Audio processing
func _check_for_voice() -> void:
	if Steam.has_method("getAvailableVoice"):
		var available_voice: Dictionary = Steam.call("getAvailableVoice")

		if available_voice['result'] == Steam.VoiceResult.VOICE_RESULT_OK and available_voice['size'] > 0:
			_get_voice_data()


# Get the voice data from Steam and send it off for processing.  In the case of testing, when
# use_loopback is true, we just send it to ourselves.
func _get_voice_data() -> void:
	var voice_data: Dictionary = Steam.getVoice()
	if voice_data['result'] == Steam.VoiceResult.VOICE_RESULT_OK and voice_data['written'] > 0:
		# Pass the voice_data['buffer'] to process_voice_data
		if use_loopback:
			process_voice_data(voice_data['buffer'])


## Process the voice buffer and play it out through the voice_playback stream.  This must be the
## voice data buffer returned from [method Steam.getVoice]. 
func process_voice_data(voice_data: PackedByteArray) -> void:
	var decompressed_voice: Dictionary = Steam.decompressVoice(voice_data, _current_sample_rate)

	if decompressed_voice['result'] == Steam.VoiceResult.VOICE_RESULT_OK and decompressed_voice['size'] > 0:
		var frames_to_push: PackedVector2Array = PackedVector2Array()
		frames_to_push.resize(decompressed_voice['size'] / 2)

		for i in range(0, decompressed_voice['size'], 2):
			var sample_int: int = decompressed_voice['uncompressed'].decode_s16(i)
			var amplitude: float = float(sample_int) / 32768.0
			frames_to_push[i / 2] = Vector2(amplitude,  amplitude)

		if _voice_playback.get_frames_available() >= frames_to_push.size():
			_voice_playback.push_buffer(frames_to_push)
		elif _voice_playback.get_frames_available() > 0:
			_voice_playback.push_buffer(frames_to_push.slice(0, _voice_playback.get_frames_available()))


## Record the voice of the local user. You must pass the local user's Steam ID.
func record_voice(steam_id: int = 0, is_recording: bool = true) -> void:
	if steam_id > 0:
		Steam.setInGameVoiceSpeaking(steam_id, is_recording)

		if is_recording:
			Steam.startVoiceRecording()
		else:
			Steam.stopVoiceRecording()
#endregion


#region Set-gets
func _set_optimal_sample_rate(is_optimal: bool) -> void:
	use_optimal_sample_rate = is_optimal

	if use_optimal_sample_rate:
		_current_sample_rate = Steam.getVoiceOptimalSampleRate()
	else:
		_current_sample_rate = SAMPLE_RATE
#endregion
