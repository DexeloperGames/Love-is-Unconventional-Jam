@tool
extends StaticBody2D

@export var velocity : Vector2i = Vector2i(0,0)
@export var R = true:
	set(new_R):
		R = new_R
		update_colors()
@export var G = false:
	set(new_G):
		G = new_G
		update_colors()
@export var B = false:
	set(new_B):
		B = new_B
		update_colors()

func update_colors():
	modulate = Color(float(R),float(G),float(B))
	set_collision_layer_value(1,R)
	set_collision_layer_value(2,G)
	set_collision_layer_value(3,B)
	
	set_collision_mask_value(1,R)
	set_collision_mask_value(2,G)
	set_collision_mask_value(3,B)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
class InputCache:
	var directional_pressed : bool = false
	var directional_x : int = 0
	var jump_pressed = false
var jump_time : int = 3
var cached_input : InputCache = InputCache.new()
func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	var on_ground : bool = not move_and_collide(Vector2i(0,1),true) == null
	var on_ceiling : bool = not move_and_collide(Vector2i(0,-1),true) == null
	var on_left_wall : bool = not move_and_collide(Vector2i(-1,0),true) == null
	var on_right_wall : bool = not move_and_collide(Vector2i(1,0),true) == null
	
	var jumping = jump_time != 0
	#print(on_ground)
	if not (on_ground or jumping):
		velocity.y = 1
	elif jumping:
		velocity.y = -1
		jump_time -= 1
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("ui_up") and on_ground:
		#velocity.y = -2
		jump_time = 3
		velocity.y = -1
	if Input.is_action_just_released("ui_up"):
		jump_time = 0
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_left"):
		direction_x = -1
	if Input.is_action_just_pressed("ui_right"):
		direction_x = 1
	#if cached_input.directional_pressed:
		#direction_x = cached_input.directional_x
		
	#var direction_y = Input.get_axis("ui_up", "ui_down")
	cached_input.jump_pressed = false
	cached_input.directional_pressed = false
	velocity = Vector2i(direction_x,velocity.y)
	
	if(on_ground): velocity.y = mini(velocity.y,0)
	if(on_ceiling): velocity.y = maxi(velocity.y,0)
	if(on_left_wall): velocity.x = maxi(velocity.x,0)
	if(on_right_wall): velocity.x = mini(velocity.x,0)
	
	var collision = move_and_collide(velocity, true)
	if(collision):
		var second_check : Vector2i = velocity*Vector2i(0,1)
		var third_check : Vector2i = velocity*Vector2i(1,0)
		
		var second_collision = move_and_collide(second_check, true)
		if second_collision:
			var third_collision = move_and_collide(third_check, true)
			if not third_collision:
				velocity = third_check
		else:
			velocity = second_check
		pass
	move_and_collide(velocity)
	position = Vector2i(roundi(position.x),roundi(position.y))
	pass

func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		cached_input.directional_x = roundi(Input.get_axis("ui_left", "ui_right"))
		cached_input.directional_pressed = true
	
	#cached_input.directional_x = roundi(Input.get_axis("ui_left", "ui_right"))
	#cached_input.directional_pressed = not cached_input.directional_x == 0
	#if cached_input.directional_x == 0: cached_input.directional_pressed = false
	if event.is_action_pressed("ui_up"):
		cached_input.jump_pressed = true
