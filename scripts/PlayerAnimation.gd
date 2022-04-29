extends AnimatedSprite

#direction facing varaible
var faceDir

#on start
func _ready():
	faceDir = 1

#update
func _process(_delta):
	#animate sprite to face last accelerating direction
	if faceDir == 1:
		set_flip_h(false)
	else:
		set_flip_h(true)
