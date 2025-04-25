extends Control

const FLECHA = preload("res://flecha.tscn")

@onready var lista_de_comandos: VBoxContainer = $"../../Lista de Comandos"

func add_arrow_list(amount: int):
	var start_count = get_child_count()
	
	for i in range(amount):
		var flecha = FLECHA.instantiate()
		flecha.direction = randi_range(0, 3)
		lista_de_comandos.add_child(flecha)

func remove_arrow():
	if get_child_count() > 0:
		get_child(0).queue_free()

func _on_aparecer_flecha_timeout():
	add_arrow_list(3)  # Agora adiciona 3 flechas de uma vez

func _on_camera_2d_swipe(directionIndex):
	if get_child_count() > 0 and get_child(0).direction == directionIndex:
		remove_arrow()
