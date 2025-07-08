extends Node

var pontuaçãoAtual:int = 0
var pontuações = []
var nivelDificuldade:int = 0

var setasExplicadas:Array = [false, false, false, false, false]
# AZUL = 0, LARANJA = 1, CINZA = 2, CORAÇÃO = 3, DOUBLE = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pontuaçãoAtual = 0
	pontuações.append(0)
	pontuações.append(0)
	pontuações.append(0)

func addPoints(amount):
	pontuaçãoAtual += amount

func aumentarDificuldade():
	nivelDificuldade += 1

func gameOver():
	pontuações.append(pontuaçãoAtual)
	pontuações.sort()
	pontuações.reverse()
	nivelDificuldade = 0
