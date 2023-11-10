class_name NodeCube extends Node3D

@onready var white_pivot: CubePivot = $WhitePivot
@onready var blue_pivot: CubePivot = $BluePivot
@onready var orange_pivot: CubePivot = $OrangePivot
@onready var red_pivot: CubePivot = $RedPivot
@onready var green_pivot: CubePivot = $GreenPivot
@onready var yellow_pivot: CubePivot = $YellowPivot

@onready var camera_rotation_point: Node3D = $CameraRotationPoint
@onready var camera: Camera3D = $CameraRotationPoint/Camera3D

var ready_to_act: bool = true
var input_queue: Array[InputEvent] = []

const anim_speed: float = 0.07
const ROTATE_RIGHT = PI / 2
const ROTATE_LEFT = -1 * ROTATE_RIGHT
const sensitvity: float = 0.008

func _unhandled_input(event: InputEvent) -> void:

	if event is InputEventMouseMotion:
		camera_rotation_point.rotate_object_local(Vector3.UP, event.relative.x * sensitvity)
		camera_rotation_point.rotate_object_local(Vector3.RIGHT, event.relative.y * sensitvity)
		#event.relative
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	else:
		input_queue.push_back(event)
	#get_viewport().set_input_as_handled()

func _process(_delta: float) -> void:
	if ready_to_act:
		if len(input_queue) > 0:
			handle_input_event(input_queue.pop_front())

func handle_input_event(event: InputEvent) -> void:
	if event is InputEventMouse || event is InputEventGesture: return
	var rotate_direction: float = ROTATE_RIGHT
	if event is InputEventKey:
		if event.shift_pressed:
			rotate_direction = ROTATE_LEFT
	else:
		return
	var old_ready_to_act := ready_to_act
	ready_to_act = false
	var rot := get_tree().create_tween()
	rot.connect("finished", _anim_finished)
	if event.is_action_pressed("rotate_bottom"):
		yellow_pivot.take_ownership_of_pieces()
		rot.tween_property(yellow_pivot, "rotation", yellow_pivot.rotation + Vector3(0, rotate_direction, 0), anim_speed)
	elif event.is_action_pressed("rotate_left"):
		orange_pivot.take_ownership_of_pieces()
		rot.tween_property(orange_pivot, "rotation", orange_pivot.rotation + Vector3(rotate_direction, 0, 0), anim_speed)
	elif event.is_action_pressed("rotate_right"):
		red_pivot.take_ownership_of_pieces()
		rot.tween_property(red_pivot, "rotation", red_pivot.rotation + Vector3(rotate_direction, 0, 0), anim_speed)
	elif event.is_action_pressed("rotate_top"):
		white_pivot.take_ownership_of_pieces()
		rot.tween_property(white_pivot, "rotation", white_pivot.rotation + Vector3(0, rotate_direction, 0), anim_speed)
	elif event.is_action_pressed("rotate_front"):
		green_pivot.take_ownership_of_pieces()
		rot.tween_property(green_pivot, "rotation", green_pivot.rotation + Vector3(0, 0, rotate_direction), anim_speed)
	elif event.is_action_pressed("rotate_back"):
		blue_pivot.take_ownership_of_pieces()
		rot.tween_property(blue_pivot, "rotation", blue_pivot.rotation + Vector3(0, 0, rotate_direction), anim_speed)
	else:
		rot.kill()
		ready_to_act = old_ready_to_act

func _anim_finished() -> void:
	call_deferred("_after_collision_handler")

func _after_collision_handler() -> void:
	await get_tree().physics_frame
	ready_to_act = true

