extends AudioStreamPlayer


export(Array, AudioStream) var audio_files: Array

var audio_files_size: int

func _ready():
  randomize()
  audio_files_size = audio_files.size()

func play_random():
  var random_index: = randi() % audio_files_size
  stop()
  stream = audio_files[random_index]
  play()
