extends Node

var pontuaçãoAtual:int = 0
var pontuações = []

var nivelDificuldade:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pontuaçãoAtual = 0

func addPoints(amount):
	pontuaçãoAtual += amount

func aumentarDificuldade():
	nivelDificuldade += 1


func gameOver():
	pontuações.append(pontuaçãoAtual)
	pontuações.sort()
	pontuações.reverse()
