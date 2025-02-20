extends Node3D

func _ready() -> void:
	GlobalVariables.connect("quota_changed", quota_changed)
	EventBus.gl_event_timer.connect("timeout", update_time)
	quota_changed(GlobalVariables.gl_qt_now)

func update_time():
	$info_panel/now_note2.text = "time left: " + str(round(EventBus.timer_to_day_end.time_left))

func quota_changed(v: int):
	$info_panel/now_note.text = "quota: " + str(v)
