extends Node

signal complete

var unlocked : PoolStringArray

func complete(level):
	emit_signal("complete", level)
	
func _ready():
	connect("complete", self, "add")
	unlocked.append("1")
	
func add(level):
	for n in unlocked:
		if n == str(level + 1):
			return
	unlocked.append(str(level + 1))
