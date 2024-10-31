extends SubViewportContainer

@export var subviewport: SubViewport

func _input(_event):
	subviewport.handle_input_locally = true
	subviewport.physics_object_picking = true
