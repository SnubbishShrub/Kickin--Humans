extends Node


signal Kicked
signal Break

func Kicked():
	emit_signal("Kicked", 0.2)
	
func Break():
	emit_signal("Break", 0.7)
