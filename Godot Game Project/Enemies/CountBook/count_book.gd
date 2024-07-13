extends Area2D

var battle = preload("res://Game/battle_scene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if "Player" in body.name:
		var numberOfMinions: int = randi_range(0,2)
		get_tree().paused = true
		
		var fight = battle.instantiate()
		for n in numberOfMinions:
			battle.addEnemy()
		get_parent().add_child(fight)
		queue_free()
