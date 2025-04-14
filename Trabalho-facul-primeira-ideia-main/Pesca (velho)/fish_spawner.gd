extends Node2D


const PEIXE = preload("res://Pesca (velho)/peixe.tscn")

@onready var spawners = {
	1: $"Spawner Esquerda",
	2: $"Spawner Esquerda2",
	3: $"Spawner Esquerda3",
	4: $"Spawner Esquerda4",
	5: $"Spawner Esquerda5",
	6: $"Spawner Esquerda6",
	7: $"Spawner Direita",
	8: $"Spawner Direita2",
	9: $"Spawner Direita3",
	10: $"Spawner Direita4",
	11: $"Spawner Direita5",
	12: $"Spawner Direita6"
}

func rand_spot() -> Vector2:
	var random_index = randi_range(1, 12)
	return spawners[random_index].position

func spawn_fish():
	var peixe = PEIXE.instantiate()
	peixe.position = rand_spot()
	if peixe.position.x > 0:
		peixe.andar_esquerda = true
	get_parent().add_child(peixe)

func _on_timer_timeout() -> void:
	spawn_fish()
