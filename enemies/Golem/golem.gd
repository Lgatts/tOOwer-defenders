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
	enemy_type = Enums.EnemiesType.GOLEM

func _ready():
	if(element == Enums.Elements.FIRE):
		maxHealth = 200
		droped_gold = 100
	if(element == Enums.Elements.WATER):
		maxHealth = 200
		droped_gold = 200
	if(element == Enums.Elements.EARTH):
		maxHealth = 400
		droped_gold = 250
	if(element == Enums.Elements.WIND):
		maxHealth = 500
		droped_gold = 300
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 600
		droped_gold = 400
	super._ready()
