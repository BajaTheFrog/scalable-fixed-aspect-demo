@tool
extends Node2D
class_name ViewportBoundaryController

@export var top_edge_body: StaticBody2D
@export var left_edge_body: StaticBody2D
@export var right_edge_body: StaticBody2D
@export var bottom_edge_body: StaticBody2D
@export_flags_2d_physics var collision_layer: int = 1:
	set(value):
		collision_layer = value
		_update_layers(value)
@export_flags_2d_physics var collision_mask: int = 1:
	set(value):
		collision_mask = value
		_update_masks(value)

var update_on_next_physics_frame = false

func _ready() -> void:
	_update_boundaries()
	_update_layers(collision_layer)
	_update_masks(collision_mask)
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_update_boundaries()
	
	
func _physics_process(delta: float) -> void:
	if update_on_next_physics_frame:
		_update_boundaries()
		update_on_next_physics_frame = false
	

func _on_viewport_size_changed() -> void:
	update_on_next_physics_frame = true


func _update_boundaries() -> void:
	var viewport_rect = get_viewport().get_visible_rect()
	top_edge_body.global_position = viewport_rect.position # top left
	left_edge_body.global_position = Vector2(viewport_rect.position.x, viewport_rect.end.y) # bottom left
	right_edge_body.global_position = Vector2(viewport_rect.end.x, viewport_rect.position.y) # top right
	bottom_edge_body.global_position = viewport_rect.end # bottom right
	
	
func _update_layers(value: int) -> void:
	top_edge_body.collision_layer = value
	left_edge_body.collision_layer = value
	right_edge_body.collision_layer = value
	bottom_edge_body.collision_layer = value
	
	
func _update_masks(value: int) -> void:
	top_edge_body.collision_mask = value
	left_edge_body.collision_mask = value
	right_edge_body.collision_mask = value
	bottom_edge_body.collision_mask = value
