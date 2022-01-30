extends Node2D

onready var guy = get_node("../Small Guy")

func _process(_delta):
	if $KinematicBody2D/Area2D.overlaps_body(guy) and \
	get_node("../Small Guy").get("kicked") == true:
		$KinematicBody2D/CollisionShape2D.disabled = true
		KickAndBreak.Break()
