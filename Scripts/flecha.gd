extends Sprite2D

@onready var Lista: Control = $"../.."

const SETA_AZUL = preload("res://Assets/Finais/UI/GUI/seta azul.png")
const SETA_CINZA = preload("res://Assets/Finais/UI/GUI/seta cinza.png")
const SETA_CORAÇÃO = preload("res://Assets/Finais/UI/GUI/seta coração.png")
const SETA_LARANJA = preload("res://Assets/Finais/UI/GUI/seta laranja.png")

@export var direction = 0

enum Tipo {AZUL = 0, LARANJA = 1, CINZA = 2, CORAÇÃO = 3, DOUBLE = 4}
var setaAtual = Tipo.AZUL

var enemyAtk = null
var SetasPossiveis = {0:true, 1:true, 2:true, 3:true}

func _ready() -> void:
	# determina se vai uma animação de ataque do inimigo ou do player
	if enemyAtk == null:
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
	
	match seta:
		Tipo.AZUL:
			texture = SETA_AZUL
			setaAtual = Tipo.AZUL
		Tipo.LARANJA:
			texture = SETA_LARANJA
			setaAtual = Tipo.LARANJA
			Lista.setaContadorLaranja = 1
		Tipo.CINZA:
			texture = SETA_CINZA
			setaAtual = Tipo.CINZA
		Tipo.CORAÇÃO:
			texture = SETA_CORAÇÃO
			setaAtual = Tipo.CORAÇÃO
		Tipo.DOUBLE:
			texture = SETA_AZUL
			setaAtual = Tipo.DOUBLE

func randSeta():
	# Valores
	# 0 = Azul
	# 1 = Laranja
	# 2 = Coração
	# 3 = Cinza
	var pool:Dictionary = {0:20, 1:15, 2:8, 3:1}
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
