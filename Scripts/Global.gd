extends Node

var pontuaçãoAtual: int = 0
var pontuações = []


func _ready() -> void :
	pontuaçãoAtual = 0

func addPoints(amount):
	pontuaçãoAtual += amount

func gameOver():
	pontuações.append(pontuaçãoAtual)
	pontuações.sort()
	pontuações.reverse()
