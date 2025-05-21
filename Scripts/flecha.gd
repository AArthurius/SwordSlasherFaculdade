extends Sprite2D

const SETA_AZUL = preload("res://Assets/Finais/UI/GUI/seta azul.png")
const SETA_CINZA = preload("res://Assets/Finais/UI/GUI/seta cinza.png")
const SETA_CORAÇÃO = preload("res://Assets/Finais/UI/GUI/seta coração.png")
const SETA_LARANJA = preload("res://Assets/Finais/UI/GUI/seta laranja.png")

@export var direction = 0

#azul - 0
var laranja = false# - 1
var cinza = false# - 2
var coração = false# - 3
var double = false# - 4 - não implementado ainda

var enemyAtk = false
var SetasPossiveis = {0:true, 1:true, 2:true, 3:true}


func _ready() -> void:
	# determina se vai uma animação de ataque do inimigo ou do player
	if randi_range(0, 1) == 0: 
		enemyAtk= true 
	else:
		enemyAtk = false
	
	setArrowType()
	
	#muda a orientação sprite com relação a direção -> setada no node Lista de Comandos
	setSpriteDirection()

func setArrowType():
	var seta = randSeta()
	while(SetasPossiveis[seta] == false):
		seta = randSeta()
		print(seta)
	
	match seta:
		0:
			texture = SETA_AZUL
		1:
			texture = SETA_LARANJA
			laranja = true
		2:
			texture = SETA_CINZA
			cinza = true
		3:
			texture = SETA_CORAÇÃO
			coração = true

func randSeta():
	# Valores
	# 0 = Azul
	# 1 = Laranja
	# 2 = Coração
	# 3 = Cinza
	var pool:Dictionary = {0:20, 1:12, 2:8, 3:1}
	var totalWeight = 0
	
	for i in pool:
		totalWeight += pool[i]
	
	var rand = randi_range(0, totalWeight - 1)
	
	for key in [0,1,2,3]:
		rand = rand - pool[key]
		if rand < 0:
			return key

func setSpriteDirection():
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
