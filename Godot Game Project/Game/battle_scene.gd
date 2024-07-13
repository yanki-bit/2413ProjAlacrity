extends CanvasLayer

var enemy1
var enemy2
var enemy3


# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemiesVContainer/EnemiesHContainer/LeftEnemy/LeftEnemyController.add_child(e1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	


