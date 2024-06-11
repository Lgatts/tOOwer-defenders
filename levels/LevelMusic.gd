extends AudioStreamPlayer

@export var fade_duration : float = 3.0
@export var target_volume_db : float = -15.0
var initial_volume_db : float = -80.0
var timer : float = 0.0

func _ready():
	set_process(false)
	self.volume_db = initial_volume_db	

func _process(delta : float) -> void:
	if timer < fade_duration:
		timer += delta
		var volume_ratio = timer / fade_duration
		self.volume_db = lerp(initial_volume_db, target_volume_db, volume_ratio)
	else:
		self.volume_db = target_volume_db
		set_process(false)

func lerp(start : float, end : float, weight : float) -> float:
	return start + weight * (end - start)

func play_level_music():
	self.play()
	set_process(true)
