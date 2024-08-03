extends Node2D

func create(x_size, y_size, color):
	$"ColorRect".scale.x = x_size
	$"ColorRect".scale.y = y_size
	$"ColorRect".color = color


