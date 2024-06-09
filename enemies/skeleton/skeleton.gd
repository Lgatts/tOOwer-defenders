extends Enemy

func _init():
	textures = {
		Enums.Elements.FIRE: preload("res://assets/enemies/FireSkeleton.png"),
		Enums.Elements.WATER: preload("res://assets/enemies/WaterSkeleton.png"),
		Enums.Elements.EARTH: preload("res://assets/enemies/EarthSkeleton.png"),
		Enums.Elements.WIND: preload("res://assets/enemies/WindSkeleton.png"),
		Enums.Elements.NEUTRAL: preload("res://assets/enemies/NeutralSkeleton.png")
	}
	maxHealth = 10
	speed = 0.6

func _ready():	
	if(element == Enums.Elements.FIRE):
		maxHealth = 10
		speed = 0.4
	if(element == Enums.Elements.WATER):
		maxHealth = 15
	if(element == Enums.Elements.EARTH):
		maxHealth = 20
	if(element == Enums.Elements.WIND):
		maxHealth = 25
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 30
	super._ready()
