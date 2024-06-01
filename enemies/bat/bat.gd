extends Enemy

func _init():
	textures = {
		Enums.Elements.FIRE: preload("res://assets/enemies/NeutralBat.png"),
		Enums.Elements.WATER: preload("res://assets/enemies/NeutralBat.png"),
		Enums.Elements.EARTH: preload("res://assets/enemies/NeutralBat.png"),
		Enums.Elements.WIND: preload("res://assets/enemies/NeutralBat.png"),
		Enums.Elements.NEUTRAL: preload("res://assets/enemies/NeutralBat.png")
	}
	speed = 5
	damage = 8
