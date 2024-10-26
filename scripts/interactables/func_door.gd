@tool
class_name FuncDoor
extends AnimatableBody3D

@export var interactable: bool = true

@export var max_rotation: float

var rotation_dir: int
var closed: bool
var limit: float

var rotate_speed: float = 0.03

func _func_godot_apply_properties(props: Dictionary) -> void:
	max_rotation = props["max_rotation"] as float

func execute() -> void:
	if closed:
		closed = false

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if !closed:
		var should_rotate = (rotation.y + rotate_speed < limit) if (rotation_dir == 1) else (rotation.y - rotate_speed > limit)
		if should_rotate:
			rotate_y(rotate_speed * rotation_dir)
		else:
			rotation.y = limit
			closed = true
			rotation_dir = -rotation_dir
			if limit == 0:
				limit = max_rotation
			else:
				limit = 0

func _init() -> void:
	rotation = Vector3.ZERO
	closed = true
	limit = max_rotation
	
	if max_rotation < 0:
		rotation_dir = -1
	else:
		rotation_dir = 1

func _ready() -> void:
	if Engine.is_editor_hint():
		return
