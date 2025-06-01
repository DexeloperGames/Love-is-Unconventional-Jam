extends CharacterBody2D


var SPEED = 1.0
var JUMP_VELOCITY = -2.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#print(velocity/delta)
	velocity = velocity/delta
	move_and_slide()
	velocity = velocity*delta
	position = Vector2i(position)
	#var collision = move_and_collide(velocity,false)
	#if(collision):
		#print("\n\n\n")
		#prints("get_angle", collision.get_angle())
		#prints("get_collider", collision.get_collider())
		#prints("get_collider_id", collision.get_collider_id())
		#prints("get_collider_rid", collision.get_collider_rid())
		#prints("get_collider_shape", collision.get_collider_shape())
		#prints("get_collider_shape_index", collision.get_collider_shape_index())
		#prints("get_collider_velocity", collision.get_collider_velocity())
		#prints("get_depth", collision.get_depth())
		#prints("get_local_shape", collision.get_local_shape())
		#prints("get_normal", collision.get_normal())
		#prints("get_position", collision.get_position())
		#prints("get_remainder", collision.get_remainder())
		#prints("get_travel", collision.get_travel())
		#print("\n")
