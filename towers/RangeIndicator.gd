extends Node2D

@export
var _radius = 150
var _color: Color = Color(1, 0, 0, 0.5)

func _draw():
	draw_circle(Vector2.ZERO, _radius, _color)

func update_color(color:Color):
	_color = color 
	queue_redraw()
