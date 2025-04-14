extends VBoxContainer

const FLECHA = preload("res://flecha.tscn")

var contador = 0

func _process(delta) -> void:
	if contador > 3:
		contador = 0
	if Input.is_action_just_pressed("ui_accept"):
		addArrow(contador)
		contador += 1

func addArrowList(amount: int):
	for i in amount:
		var flecha = FLECHA.instantiate()
		flecha.direction = randi_range(0,3)
		add_child(flecha)

func addArrow(direção):
	#0 direita
	#1 esquerda
	#2 cima
	#3 baixo
	var flecha = FLECHA.instantiate()
	flecha.direction = direção
	get_children().size()
	add_child(flecha)

func removeArrow(index):
	get_child(index).queue_free()

func checkArrow(swipeDirection):
	if get_child(0).direction == swipeDirection:
		get_child(0).queue_free()

func _on_camera_2d_swipe(directionIndex: Variant) -> void:
	if get_child_count() > 0:
		checkArrow(directionIndex)

func _on_aparecer_flecha_timeout() -> void:
	addArrowList(3)
