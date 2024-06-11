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
	enemy_type = Enums.EnemiesType.SKELETON

func _ready():	
	if(element == Enums.Elements.FIRE):
		maxHealth = 10
		speed = 0.4
		droped_gold = 25
	if(element == Enums.Elements.WATER):
		maxHealth = 15
		droped_gold = 35
	if(element == Enums.Elements.EARTH):
		maxHealth = 20
		droped_gold = 45
	if(element == Enums.Elements.WIND):
		maxHealth = 25
		droped_gold = 55
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 15
		droped_gold = 65
	super._ready()
