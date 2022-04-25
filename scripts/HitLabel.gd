extends Label

#get timer component
onready var timer = get_node("FadeTimer")

#on start
func _ready():
	#start the timer lasting 1 second
	timer.start(1)

#update
func _process(_delta):
	#set transparency based on time remaining to cause fade out
	modulate.a = timer.get_time_left()

#on timer finished
func _on_FadeTimer_timeout():
	#delete the label
	queue_free()
