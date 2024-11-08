extends CharacterBody2D

const SPEED = 800.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	

func _on_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", rotation_degrees + 540, 0.3)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Sprite2D.modulate = random_color()


func random_color(saturation: float = 1, value: float = 1, alpha: float = 1) -> Color:
	var random_hue = randf_range(0, 1)
	return Color.from_hsv(random_hue, saturation, value, alpha)
