extends Sprite2D

const SETA_AZUL = preload("res://Assets/Finais/UI/GUI/seta azul.png")
const SETA_CINZA = preload("res://Assets/Finais/UI/GUI/seta cinza.png")
const SETA_CORAÇÃO = preload("res://Assets/Finais/UI/GUI/seta coração.png")
const SETA_LARANJA = preload("res://Assets/Finais/UI/GUI/seta laranja.png")


@export var direction = 0
var cinza = false
var coração = false
var enemyAtk = false

func _ready() -> void:
	if cinza:
		texture = SETA_CINZA
	elif coração:
		texture = SETA_CORAÇÃO
	else:
		texture = SETA_AZUL
		
	match direction:
		0: #left
			rotation = deg_to_rad(0)
			flip_h = true
		1: #right
			rotation = deg_to_rad(0)
			flip_h = false
		2: #up
			rotation = deg_to_rad(90)
			flip_h = true
		3: #down
			rotation = deg_to_rad(90)
			flip_h = false
