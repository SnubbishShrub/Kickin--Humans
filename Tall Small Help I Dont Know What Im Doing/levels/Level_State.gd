extends Node

signal complete

var unlocked : PoolStringArray

func complete(level):
	emit_signal("complete", level)
	
func _ready():
	connect("complete", self, "add")
	unlocked.append("1")
	unlocked.append("2")
	
func add(level):
	for n in unlocked:
		if n == level:
			return
	unlocked.append(level)
