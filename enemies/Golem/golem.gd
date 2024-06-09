extends Enemy

func _init():
	textures = {
		Enums.Elements.FIRE: preload("res://assets/enemies/FireGolem.png"),
		Enums.Elements.WATER: preload("res://assets/enemies/WaterGolem.png"),
		Enums.Elements.EARTH: preload("res://assets/enemies/EarthGolem.png"),
		Enums.Elements.WIND: preload("res://assets/enemies/WindGolem.png"),
		Enums.Elements.NEUTRAL: preload("res://assets/enemies/NeutralGolem.png")
	}
	speed = 0.2

func _ready():
	if(element == Enums.Elements.FIRE):
		maxHealth = 50
		droped_gold = 50
	if(element == Enums.Elements.WATER):
		maxHealth = 60
		droped_gold = 70
	if(element == Enums.Elements.EARTH):
		maxHealth = 70
		droped_gold = 90
	if(element == Enums.Elements.WIND):
		maxHealth = 80
		droped_gold = 110
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 100
		droped_gold = 150
	super._ready()
