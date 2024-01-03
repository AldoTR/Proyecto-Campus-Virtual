extends Node2D

var sprites = []  # Variable donde se almacenarán los Sprites
var texture_path = ""  # Variable para almacenar la ruta de la textura
var current_image = 1  # Variable para almacenar la imagen actual

func _ready():
	for i in range(5):
		sprites.append(Sprite2D.new())  # Usa Sprite2D en lugar de Sprite

		# Carga la textura y almacena la ruta
		var texture = load(str("res://imagen" + str(i + 1) + ".png"))
		texture_path = texture.resource_path

		# Asigna la textura al Sprite
		sprites[i].texture = texture

		# Centra la imagen inicialmente
		sprites[i].position = get_viewport().size / 2

		# Dimensiona la imagen a la ventana de ejecución inicialmente
		_resize()

		add_child(sprites[i])

func _resize():
	for i in range(len(sprites)):
		var texture_size = sprites[i].texture.get_size()

		# Calcula la escala necesaria para ajustar la imagen al tamaño más pequeño del viewport
		var scale = min(get_viewport().size.x / texture_size.x, get_viewport().size.y / texture_size.y)

		# Calcula la relación de aspecto del viewport manualmente
		var aspect_ratio = get_viewport().size.x / get_viewport().size.y

		# Calcula la escala de la imagen manteniendo la relación de aspecto
		var scale_x = scale * aspect_ratio
		var scale_y = scale / aspect_ratio

		# Establece la escala del Sprite como Vector2
		sprites[i].scale = Vector2(scale_x, scale_y) * 2.5

		# Centra la imagen nuevamente
		sprites[i].position = get_viewport().size / 2

func _input(event):
	if event.is_action_pressed("ui_right"):
		current_image = (current_image + 1) % 5
		for i in range(len(sprites)):
			sprites[i].texture = load(str("res://imagen" + str(current_image + 1) + ".png"))

	if event.is_action_pressed("ui_left"):
		current_image = (current_image - 1) % 5
		for i in range(len(sprites)):
			sprites[i].texture = load(str("res://imagen" + str(current_image + 1) + ".png"))

	# Comprueba si la imagen actual es la 0
	if current_image == 0:
		# Si es así, establece la imagen actual en 5
		current_image = 5

	# Centra la imagen nuevamente
	for i in range(len(sprites)):
		sprites[i].position = get_viewport().size / 2
