extends Node

var player: Node3D

var day: bool = false

signal quota_changed(v: int)
signal money_changed(v: int)
signal win_day

func add_quota():
	gl_daly_qt_max += gl_daly_qt_adding
	gl_qt_now = gl_daly_qt_max

var gl_money: int = 300:
	set(v):
		gl_money = v
		money_changed.emit(gl_money)

var gl_day_counter: int = 1

var gl_qt_now: int = 10:
	set(v):
		gl_qt_now = v
		quota_changed.emit(gl_qt_now)
		
		if gl_qt_now <= 0:
			add_quota()
			win_day.emit()
			day = false
var gl_daly_qt_max: int = 10
var gl_daly_qt_adding: int = 5
