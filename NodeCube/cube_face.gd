class_name CubeFace extends Node3D

@export var face_color: CubeTypes.FaceColor:
	get: return face_color
	set(v):
		face_color = v
		_update_colors()

@onready var face: CSGMesh3D = $Face

func _ready() -> void:
	_update_colors()

func _update_colors() -> void:
	# TODO: share materials somewhere
	if face:
		var material := StandardMaterial3D.new()
		var color := CubeTypes.face_color_to_color(face_color)
		material.albedo_color = color
		face.set_material(material)
