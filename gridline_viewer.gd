@tool
extends Control

@export var dimensions : Vector2i = Vector2i(16,9)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	pass

func _draw():
	for x in range(0,dimensions.x+1):
		var line_pos = size.x*float(x)/dimensions.x
		draw_line(Vector2(line_pos,0),Vector2(line_pos,size.y),Color.WHITE)
	for y in range(0,dimensions.y+1):
		var line_pos = size.y*float(y)/dimensions.y
		draw_line(Vector2(0,line_pos),Vector2(size.x,line_pos),Color.WHITE)
