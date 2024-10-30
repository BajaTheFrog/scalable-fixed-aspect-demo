extends SubViewportContainer

func _input(_event):
	$SubViewport.handle_input_locally = true
	$SubViewport.physics_object_picking = true
