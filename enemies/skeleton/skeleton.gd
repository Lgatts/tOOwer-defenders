extends Enemy

func _init():
	textures = {
		Enums.Elements.FIRE: preload("res://assets/enemies/FireSkeleton.png"),
		Enums.Elements.WATER: preload("res://assets/enemies/FireSkeleton.png"),
		Enums.Elements.EARTH: preload("res://assets/enemies/FireSkeleton.png"),
		Enums.Elements.WIND: preload("res://assets/enemies/FireSkeleton.png"),
		Enums.Elements.NEUTRAL: preload("res://assets/enemies/NeutralSkeleton.png")
	}
	maxHealth = 10
