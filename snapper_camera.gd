extends Camera2D

@export var target_node : Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_instance_valid(target_node)):
		
		position = Vector2(16,9)*Vector2(floori(target_node.position.x/16),floori(target_node.position.y/9))
	pass
	
	if(not get_viewport() is SubViewport):
		zoom = get_viewport_rect().size/Vector2(16,9)
