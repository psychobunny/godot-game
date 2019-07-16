extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

var mob_types = ['walk', 'swim', 'fly']


func _ready():
	var type = randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[type]

