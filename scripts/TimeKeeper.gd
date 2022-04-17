extends Label

var time = 0

func _process(delta):
	time += delta
	text = "Time: " + String(stepify(time, 0.01))
