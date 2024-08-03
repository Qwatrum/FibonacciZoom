extends Node2D

@onready var rect = preload("res://scenes/rect.tscn")

var colors = [Color(0,0,255), Color(0,255,0), Color(255,0,0), Color(255,0,255), Color(0, 255, 255), Color(255,255,0), Color(128,128,128), Color(0,0,0), Color(255, 255, 255), Color(0,128,128), Color(128,0,128),Color(0,0,255), Color(0,255,0), Color(255,0,0), Color(255,0,255), Color(0, 255, 255), Color(255,255,0), Color(128,128,128), Color(0,0,0), Color(255, 255, 255), Color(0,128,128), Color(128,0,128)]
var rects = []
var x_changes = [1,1,2,0] # 1 -> + | 2 -> - | 0 -> nothing
var y_changes = [0,1,1,2] # 1 -> + | 2 -> - | 0 -> nothing

func create_fibonacci_art():
	var x_size = 320
	var y_size = 640
	var x_pos = 0
	var y_pos = 0
	var last_rect = true
	for i in range(10):
		if last_rect:
			var inste_rect = rect.instantiate()
			add_child(inste_rect)
			rects.append(inste_rect)
			inste_rect.create(x_size, y_size, colors[i])
			inste_rect.position = Vector2(x_pos, y_pos)
			y_size = x_size
			last_rect = false
		else:
			var inste_rect_2 = rect.instantiate()
			add_child(inste_rect_2)
			rects.append(inste_rect_2)
			
			inste_rect_2.create(x_size, y_size, colors[i])
			inste_rect_2.position = Vector2(x_pos, y_pos)
			x_size /= 2
			last_rect = true
		
		if x_changes[i % len(x_changes)] == 1:
			x_pos += x_size
		elif x_changes[i % len(x_changes)] == 2:
			x_pos -= x_size
			
		if y_changes[i % len(y_changes)] == 1:
			y_pos += y_size
		elif y_changes[i % len(y_changes)] == 2:
			y_pos -= y_size
		
		
func _ready():
	create_fibonacci_art()
