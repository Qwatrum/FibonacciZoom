extends Node2D

@onready var rect = preload("res://scenes/rect.tscn")

var colors = [Color(0, 0.188, 0.286), Color(0.839, 0.157, 0.157), Color(0.969, 0.498, 0), Color(0.988, 0.749, 0.286), Color(0.918, 0.886, 0.718)]
var rects = []
var x_changes = [1,1,2,0] # 1 -> + | 2 -> - | 0 -> nothing
var y_changes = [0,1,1,2] # 1 -> + | 2 -> - | 0 -> nothing
var c_i = 0
var zoom_speed = 1.01
var auto = false

func create_fibonacci_base():
	var x_size = 320.0
	var y_size = 640.0
	var x_pos = 0
	var y_pos = 0
	var last_rect = true
	
	for i in range(21):
		
		if last_rect:
			
			var inste_rect = rect.instantiate()
			add_child(inste_rect)
			rects.append(inste_rect)
			inste_rect.create(x_size, y_size, colors[(i+c_i) % len(colors)])
			inste_rect.position = Vector2(x_pos, y_pos)
			y_size = x_size
			last_rect = false
			
		else:
			
			var inste_rect_2 = rect.instantiate()
			add_child(inste_rect_2)
			rects.append(inste_rect_2)
			
			inste_rect_2.create(x_size, y_size, colors[(i+c_i) % len(colors)])
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
	create_fibonacci_base()

func _process(delta):
	if Input.is_action_just_pressed("zoom") or auto:
		
		$"Camera2D".zoom *= zoom_speed
		
		if $"Camera2D".zoom.x >= 5.93:
			$"Camera2D".zoom.x = 1.495
			$"Camera2D".zoom.y = 1.495

			for e in rects:
				e.queue_free()
			rects = []
			c_i += 4
			create_fibonacci_base()
	
	if Input.is_action_just_pressed("more_speed"):
		if zoom_speed < 1.35:
			zoom_speed+=0.01
	if Input.is_action_just_pressed("less_speed"):
		if zoom_speed > 1.01:
			zoom_speed-=0.01
	if Input.is_action_just_pressed("auto"):
		auto = not auto
