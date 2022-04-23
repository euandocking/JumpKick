extends Label

onready var timer = get_node("FadeTimer")

func _ready():
	timer.start(1)

func _process(_delta):
	modulate.a = timer.get_time_left()

func _on_FadeTimer_timeout():
	queue_free()
