extends Control

const FLECHA = preload("res://flecha.tscn")

@onready var pos_0: Marker2D = $Pos0
@onready var pos_1: Marker2D = $Pos1
@onready var pos_2: Marker2D = $Pos2
@onready var pos_3: Marker2D = $Pos3
@onready var fora: Marker2D = $fora

@onready var flechas: Control = $Flechas

var contador = 0

func _process(delta) -> void:
	updateArrows()
	if contador > 3:
		contador = 0
	if Input.is_action_just_pressed("ui_accept"):
		addArrow(contador)
		contador += 1

func addArrow(direção):
	#0 direita
	#1 esquerda
	#2 cima
	#3 baixo
	var flecha = FLECHA.instantiate()
	flecha.direction = direção
	match flechas.get_children().size():
		0:
			flecha.position = pos_0.position
		1:
			flecha.position = pos_1.position
		2:
			flecha.position = pos_2.position
		3:
			flecha.position = pos_3.position
		_:
			flecha.position = fora.position
	
	flechas.add_child(flecha)
	updateArrows()

func updateArrows():
	for i in range(flechas.get_children().size()):
		match i:
			0:
				flechas.get_child(i).position = pos_0.position
			1:
				flechas.get_child(i).position = pos_1.position
			2:
				flechas.get_child(i).position = pos_2.position
			3:
				flechas.get_child(i).position = pos_3.position
			_:
				flechas.get_child(i).position = fora.position

func _on_aparecer_flecha_timeout() -> void:
	pass

func checkArrow(swipeDirection):
	if flechas.get_children().size() > 0:
		if flechas.get_child(0).direction == swipeDirection:
			flechas.get_child(0).queue_free()
			updateArrows()

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	if get_child_count() > 0:
		checkArrow(directionIndex)
