extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const DASH_SECONDS = 0.1

var current_x_direction = 1
var is_dashing = false
var dash_time_remaining = 0.0


func _physics_process(delta: float) -> void:
	if is_dashing:
		_process_dashing(delta)
	else:
		_process_floating(delta)
		
	move_and_slide()


func _process_floating(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 1.2 * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	elif Input.is_physical_key_pressed(KEY_B) and velocity.y > 0:
		velocity.y = -1 * velocity.y
		
	if Input.is_action_just_pressed("dash_left"):
		_start_dash_in_direction(Vector2i.LEFT)
		return
	elif Input.is_action_just_pressed("dash_right"):
		_start_dash_in_direction(Vector2i.RIGHT)
		return
	elif Input.is_action_just_pressed("dash_up"):
		_start_dash_in_direction(Vector2i.UP)
		return
	elif Input.is_action_just_pressed("dash_down"):
		_start_dash_in_direction(Vector2i.DOWN)
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if position.x >= get_viewport().size.x:
		current_x_direction = -1
	elif position.x <= 0:
		current_x_direction = 1
	
	if current_x_direction:
		velocity.x = current_x_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

func _process_dashing(delta: float) -> void:
	dash_time_remaining -= delta
	
	if dash_time_remaining <= 0:
		is_dashing = false
		velocity.y = clamp(velocity.y, -SPEED, SPEED)
			
	if position.x >= get_viewport().size.x:
		_start_dash_in_direction(Vector2i.LEFT, dash_time_remaining)
	elif position.x <= 0:
		_start_dash_in_direction(Vector2i.RIGHT, dash_time_remaining)
			
			
func _start_dash_in_direction(direction: Vector2i, time_remaining: float = DASH_SECONDS) -> void:
	is_dashing = true
	dash_time_remaining = time_remaining
	if direction.x != 0:
		current_x_direction = direction.x
	velocity.x = direction.x * SPEED * 15
	velocity.y = direction.y * SPEED * 15
	print(str(velocity))


func _on_button_pressed() -> void:
	if velocity.y > 0:
		velocity.y = -1 * velocity.y


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Sprite2D.modulate = random_color()


func random_color(saturation: float = 1, value: float = 1, alpha: float = 1) -> Color:
	var random_hue = randf_range(0, 1)
	return Color.from_hsv(random_hue, saturation, value, alpha)
