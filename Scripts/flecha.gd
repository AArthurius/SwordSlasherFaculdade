extends Sprite2D

const FLECHAH = preload("res://Assets/Finais/flecha azul H.png")
const FLECHAV = preload("res://Assets/Finais/flecha azul V.png")
const FLECHA_LARANJA_H = preload("res://Assets/Finais/flecha laranja H.png")
const FLECHA_LARANJA_V = preload("res://Assets/Finais/flecha laranja V.png")

@export var direction = 0
var enemyAttack = true


func _ready() -> void:
	if enemyAttack:
		match direction:
			0: #left
				texture = FLECHA_LARANJA_H
				flip_h = true
			1: #right
				texture = FLECHA_LARANJA_H
				flip_h = false
			2: #up
				texture = FLECHA_LARANJA_V
				flip_h = false
			3: #down
				texture = FLECHA_LARANJA_V
				flip_v = true
	else:
		match direction:
			0: #left
				texture = FLECHAH
				flip_h = true
			1: #right
				texture = FLECHAH
				flip_h = false
			2: #up
				texture = FLECHAV
				flip_h = false
			3: #down
				texture = FLECHAV
				flip_v = true
