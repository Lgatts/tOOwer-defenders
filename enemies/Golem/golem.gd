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
	if(element == Enums.Elements.WATER):
		maxHealth = 60		
	if(element == Enums.Elements.EARTH):
		maxHealth = 70		
	if(element == Enums.Elements.WIND):
		maxHealth = 80		
	if(element == Enums.Elements.NEUTRAL):
		maxHealth = 100		
	super._ready()
