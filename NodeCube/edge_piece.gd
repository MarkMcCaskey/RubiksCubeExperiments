class_name EdgePiece extends Node3D

@export var edge_id: CubeTypes.EdgeName

@onready var top_piece: CSGMesh3D = $TopPiece
@onready var front_piece: CSGMesh3D = $FrontPiece

var face_colors: Array[CubeTypes.FaceColor] = []

func _ready() -> void:
	add_to_group("edges")
	add_to_group("edge_" + CubeTypes.EdgeName.keys()[edge_id])
	#assert(corner_id)
	face_colors = CubeTypes.edge_to_colors(edge_id)
	_update_colors()

func _update_colors() -> void:
	# TODO: share materials somewhere
	var top_material := StandardMaterial3D.new()
	var front_material := StandardMaterial3D.new()
	var color1 := CubeTypes.face_color_to_color(face_colors[0])
	var color2 := CubeTypes.face_color_to_color(face_colors[1])
	top_material.albedo_color = color1
	front_material.albedo_color = color2
	top_piece.set_material(top_material)
	front_piece.set_material(front_material)
