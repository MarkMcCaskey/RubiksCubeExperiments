class_name CubePivot extends Node3D

@export var face_color: CubeTypes.FaceColor

@onready var cube_face: CubeFace = $CubeFace
@onready var top_right_area: Area3D = $TopRight
@onready var top_left_area: Area3D = $TopLeft
@onready var bot_right_area: Area3D = $BottomRight
@onready var bot_left_area: Area3D = $BottomLeft
@onready var top_area: Area3D = $Top
@onready var bot_area: Area3D = $Bottom
@onready var left_area: Area3D = $Left
@onready var right_area: Area3D = $Right

var top_left: CornerPiece
var top_right: CornerPiece
var bot_left: CornerPiece
var bot_right: CornerPiece

var top: EdgePiece
var bot: EdgePiece
var left: EdgePiece
var right: EdgePiece

func take_ownership_of_pieces() -> void:
	for piece in [top_left, top_right, bot_left, bot_right]:
		assert(piece, "Missing corner piece in " + CubeTypes.FaceColor.keys()[face_color])
		piece.reparent(self, true)
	for piece in [top, bot, left, right]:
		assert(piece, "Missing edge piece in " + CubeTypes.FaceColor.keys()[face_color])
		piece.reparent(self, true)

func _init_pieces() -> void:
	_init_corners()
	_init_edges()

func _init_corners() -> void:
	for a in top_left_area.get_overlapping_areas():
		_on_top_left_area_entered(a)
	for a in top_right_area.get_overlapping_areas():
		_on_top_right_area_entered(a)
	for a in bot_left_area.get_overlapping_areas():
		_on_bottom_left_area_entered(a)
	for a in bot_right_area.get_overlapping_areas():
		_on_bottom_right_area_entered(a)

func _init_edges() -> void:
	for a in top_area.get_overlapping_areas():
		_on_top_area_entered(a)
	for a in right_area.get_overlapping_areas():
		_on_right_area_entered(a)
	for a in left_area.get_overlapping_areas():
		_on_left_area_entered(a)
	for a in bot_area.get_overlapping_areas():
		_on_bottom_area_entered(a)

func _ready() -> void:
	cube_face.face_color = face_color
	call_deferred("_setup")

func _setup() -> void:
	await get_tree().physics_frame
	_init_pieces()

func _on_top_left_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is CornerPiece:
		top_left = p

func _on_top_left_area_exited(_area: Area3D) -> void:
	#top_left = null
	pass


func _on_top_right_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is CornerPiece:
		top_right = p

func _on_top_right_area_exited(_area: Area3D) -> void:
	#top_right = null
	pass


func _on_bottom_left_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is CornerPiece:
		bot_left = p

func _on_bottom_left_area_exited(_area: Area3D) -> void:
	#bot_left = null
	pass


func _on_bottom_right_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is CornerPiece:
		bot_right = p

func _on_bottom_right_area_exited(_area: Area3D) -> void:
	#bot_right = null
	pass


func _on_top_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is EdgePiece:
		top = p

func _on_top_area_exited(_area: Area3D) -> void:
	#top = null
	pass


func _on_bottom_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is EdgePiece:
		bot = p

func _on_bottom_area_exited(_area: Area3D) -> void:
	#bot = null
	pass


func _on_left_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is EdgePiece:
		left = p

func _on_left_area_exited(_area: Area3D) -> void:
	pass


func _on_right_area_entered(area: Area3D) -> void:
	var p := area.get_parent()
	if p is EdgePiece:
		right = p

func _on_right_area_exited(_area: Area3D) -> void:
	pass
	#right = null
