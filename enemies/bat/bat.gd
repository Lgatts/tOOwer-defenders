extends Enemy

func _init():
	textures = {
		Enums.Elements.FIRE: preload("res://assets/enemies/FireBat.png"),
		Enums.Elements.WATER: preload("res://assets/enemies/WaterBat.png"),
		Enums.Elements.EARTH: preload("res://assets/enemies/EarthBat.png"),
		Enums.Elements.WIND: preload("res://assets/enemies/WindBat.png"),
		Enums.Elements.NEUTRAL: preload("res://assets/enemies/NeutralBat.png")
	}	
	damage = 2

func _ready():	
	if(element == Enums.Elements.FIRE):
		maxHealth = 5
		speed = 1
		droped_gold = 25
	if(element == Enums.Elements.WATER):
		maxHealth = 15
		speed = 2
		droped_gold = 35
	if(element == Enums.Elements.EARTH):
		maxHealth = 20
		speed = 2
		droped_gold = 45
	if(element == Enums.Elements.WIND):
		maxHealth = 10
		speed = 2
		droped_gold = 55
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 10
		speed = 2
		droped_gold = 65
	super._ready()	
