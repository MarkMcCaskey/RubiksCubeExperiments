class_name CornerPiece extends Node3D

@export var corner_id: CubeTypes.CornerName

@onready var top_piece: CSGMesh3D = $TopPiece
@onready var front_piece: CSGMesh3D = $FrontPiece
@onready var right_piece: CSGMesh3D = $RightPiece

var face_colors: Array[CubeTypes.FaceColor] = []

func _ready() -> void:
	add_to_group("corners")
	add_to_group("corner_" + CubeTypes.CornerName.keys()[corner_id])
	#assert(corner_id)
	face_colors = CubeTypes.corner_to_colors(corner_id)
	_update_colors()

func _update_colors() -> void:
	# TODO: share materials somewhere
	var top_material := StandardMaterial3D.new()
	var front_material := StandardMaterial3D.new()
	var right_material := StandardMaterial3D.new()
	var color1 := CubeTypes.face_color_to_color(face_colors[0])
	var color2 := CubeTypes.face_color_to_color(face_colors[1])
	var color3 := CubeTypes.face_color_to_color(face_colors[2])
	top_material.albedo_color = color1
	front_material.albedo_color = color2
	right_material.albedo_color = color3
	top_piece.set_material(top_material)
	front_piece.set_material(front_material)
	right_piece.set_material(right_material)
